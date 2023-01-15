#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <stdlib.h>
#include <sys/msg.h>
#include <unistd.h>
#include <sys/wait.h>

int proc_num;

double get_wtime(void)
{
    struct timeval t;
    gettimeofday(&t, NULL);
    return (double)t.tv_sec + (double)t.tv_usec*1.0e-6;
}

double f(double x)
{
    return log(x)*sqrt(x);
}

typedef struct {
    long mestype;
    double res;
} mess;

void child(int id, double a, double b, unsigned long n, double dx, int msqid)
{
    double S = 0;
    double local_a = a + id * (b - a) / proc_num;
    double local_b = a + (id + 1) * (b - a) / proc_num;
    for (unsigned long i = 0; i < n; i++) {
        double xi = local_a + (i + 0.5)*dx;
        S += f(xi);
    }
    S *= dx;
    mess message;
    message.mestype = 1;
    message.res = S;
    msgsnd(msqid, &message, sizeof(double), 0);
    exit(0);
    }

    int main(int argc, char *argv[])
    {
        key_t key;
        key = ftok("prokgfile", 65);

    if (argc != 2) {
        printf("Please enter a number of Processes \n");
        return 1;
    }

    proc_num = atoi(argv[1]);
    if (proc_num <= 0) {
        printf("Invalid number of processes \n");
        return 1;
    }
    double a = 1.0;
    double b = 4.0;
    unsigned long const n = 1e9;
    const double dx = (b-a)/n;
    double S = 0;
    double t0 = get_wtime();

    int msqid = msgget(key, 0644 | IPC_CREAT);

    for (int i = 0; i < proc_num; i++) {
        pid_t pid = fork();
        if (pid == 0) {
            child(i, a, b, n, dx, msqid);
        }
    }

    for (int i = 0; i < proc_num; i++) {
        wait(NULL);
    }

    mess message;

    for (int i = 0; i < proc_num; i++){
        msgrcv(msqid, &message, sizeof(double), 1, 0);
        S += message.res;
    }
    double t1 = get_wtime();
    printf("Time=%lf seconds, Result=%.8f\n", t1-t0, S);
}
