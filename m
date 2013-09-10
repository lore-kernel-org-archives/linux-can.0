From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] slcand: add slcan_attach and UART settings
Date: Tue, 10 Sep 2013 09:43:58 +0200
Message-ID: <CAGm1_kttw2GV9gz3dHYCzzU69Zj3Ed0uWfvGoTB3JVniVPJckg@mail.gmail.com>
References: <522449EC.3060705@i2se.com> <52245AD9.6030806@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:54858 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab3IJHoU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 03:44:20 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so2695536bkb.20
        for <linux-can@vger.kernel.org>; Tue, 10 Sep 2013 00:44:19 -0700 (PDT)
In-Reply-To: <52245AD9.6030806@i2se.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Stefan, hi Oliver,

I've implemented some suggestions and sent v2, but there are some
places, where I'm not sure how it should be really implemented, so I
just left comments like "Oliver?".

On Mon, Sep 2, 2013 at 11:31 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hello Yegor,
>
> as requested on GitHub here are my comments:
>
>> slcand takes settings known from slcan_attach to configure CAN
>> interface, like open/close channel, set bitrate etc. In addition -S
>> option sets UART's baudrate. This way slcand combines three utilities
>> in one: old slcand, slcan_attach and stty.
>>
>> Example: slcand -o -s8 -S 3000000 ttyUSB0
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>  slcand.c |  295
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 files changed, 256 insertions(+), 39 deletions(-)
>>
>> diff --git a/slcand.c b/slcand.c
>> index 807ffaa..92ffa20 100644
>> --- a/slcand.c
>> +++ b/slcand.c
>> @@ -40,16 +40,16 @@
>>  #include <stdlib.h>
>>  #include <string.h>
>>  #include <unistd.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>>  #include <fcntl.h>
>>  #include <syslog.h>
>>  #include <errno.h>
>>  #include <pwd.h>
>>  #include <signal.h>
>> -#include <sys/socket.h>
>>  #include <sys/ioctl.h>
>> -#include <sys/types.h>
>> -#include <sys/stat.h>
>>  #include <net/if.h>
>> +#include <termios.h>
>>
>>  /* default slcan line discipline since Kernel 2.6.25 */
>>  #define LDISC_N_SLCAN 17
>> @@ -69,46 +69,126 @@
>>  #define EXIT_SUCCESS 0
>>  #define EXIT_FAILURE 1
>>
>> +
>> +
>>  void print_usage(char *prg)
>>  {
>> -    fprintf(stderr, "\nUsage: %s tty [name]\n\n", prg);
>> -    fprintf(stderr, "Example:\n");
>> -    fprintf(stderr, "%s ttyUSB1\n", prg);
>> -    fprintf(stderr, "%s ttyS0 can0\n", prg);
>> +    fprintf(stderr, "\nUsage: %s [options] <tty> [canif-name]\n\n", prg);
>> +    fprintf(stderr, "Options: -o         (send open command 'O\\r')\n");
>> +    fprintf(stderr, "         -c         (send close command 'C\\r')\n");
>> +    fprintf(stderr, "         -f         (read status flags with 'F\\r'
>> to reset error states)\n");
>> +    fprintf(stderr, "         -s <speed> (set CAN speed 0..8)\n");
>> +    fprintf(stderr, "         -S <speed> (set UART speed)\n");
>
>
> It would be nice for the user to know the range of the UART speed and it is
> in baud.
>
>> + fprintf(stderr, "         -b <btr>   (set bit time register value)\n");
>> +    fprintf(stderr, "         -F         (stay in foreground; no
>> daemonize)\n");
>> +    fprintf(stderr, "         -h         (show this help page)\n");
>> +    fprintf(stderr, "\nExamples:\n");
>> +    fprintf(stderr, "slcand -o -c -f -s6 ttyslcan0\n");
>> +    fprintf(stderr, "slcand -o -c -f -s6 ttyslcan0 can0\n");
>>      fprintf(stderr, "\n");
>>      exit(EXIT_FAILURE);
>>  }
>>
>> +
>> +static int slcand_running = 0;
>> +static int exit_code = 0;
>> +static char ttypath[TTYPATH_LENGTH];
>> +static char pidfile[PIDFILE_LENGTH];
>> +
>> +
>>  static void child_handler (int signum)
>>  {
>>      switch (signum)
>>      {
>> -    case SIGALRM:
>> -        exit (EXIT_FAILURE);
>> -        break;
>>      case SIGUSR1:
>> -        exit (EXIT_SUCCESS);
>> +        /* exit parent */
>> +        exit(EXIT_SUCCESS);
>
>
> Please try to keep code convention.

Fixed

>> break;
>> +    case SIGALRM:
>>      case SIGCHLD:
>> -        exit (EXIT_FAILURE);
>> +        syslog (LOG_NOTICE, "received signal %i on %s", signum, ttypath);
>> +        exit_code = EXIT_FAILURE;
>> +        slcand_running = 0;
>> +        break;
>> +    case SIGINT:
>> +    case SIGTERM:
>> +        syslog (LOG_NOTICE, "received signal %i on %s", signum, ttypath);
>> +        exit_code = EXIT_SUCCESS;
>> +        slcand_running = 0;
>>          break;
>>      }
>>  }
>>
>> -static void daemonize (const char *lockfile, char *tty)
>> +static int look_up_uart_speed(int s)
>
>
> As my comment on GitHub, i think int isn't 32 bit or high on all platforms.
> So please change the datatype of parameter s to make sure the maximum like
> 4000000 is always reached like long or int32_t. Btw speed would be a better
> variable name.

Fixed. speed refers to CAN speed.

>> +{
>> +    switch (s) {
>> +    case 9600:
>> +        return B9600;
>> +    case 19200:
>> +        return B19200;
>> +    case 38400:
>> +        return B38400;
>> +    case 57600:
>> +        return B57600;
>> +    case 115200:
>> +        return B115200;
>> +    case 230400:
>> +        return B230400;
>> +    case 460800:
>> +        return B460800;
>> +    case 500000:
>> +        return B500000;
>> +    case 576000:
>> +        return B576000;
>> +    case 921600:
>> +        return B921600;
>> +    case 1000000:
>> +        return B1000000;
>> +    case 1152000:
>> +        return B1152000;
>> +    case 1500000:
>> +        return B1500000;
>> +    case 2000000:
>> +        return B2000000;
>> +#ifdef B2500000
>> +    case 2500000:
>> +        return B2500000;
>> +#endif
>> +#ifdef B3000000
>> +    case 3000000:
>> +        return B3000000;
>> +#endif
>> +#ifdef B3500000
>> +    case 3500000:
>> +        return B3500000;
>> +#endif
>> +#ifdef B3710000
>> +    case 3710000
>> +        return B3710000;
>> +#endif
>> +#ifdef B4000000
>> +    case 4000000:
>> +        return B4000000;
>> +#endif
>> +    default:
>> +        return B57600;
>
>
> I believe it isn't a good behaviour to return 57600 in error case. So better
> return a special error value like -1 and handle this error case.

Fixed

>> +    }
>> +}
>> +
>> +static pid_t daemonize (const char *lockfile, char *tty, char *name)
>>  {
>>      pid_t pid, sid, parent;
>>      int lfp = -1;
>>      FILE * pFile;
>> +    FILE * dummyFile;
>>      char const *pidprefix = "/var/run/";
>>      char const *pidsuffix = ".pid";
>> -    char pidfile[PIDFILE_LENGTH];
>>
>>      snprintf(pidfile, PIDFILE_LENGTH, "%s%s-%s%s", pidprefix,
>> DAEMON_NAME, tty, pidsuffix);
>>
>>      /* already a daemon */
>>      if (getppid () == 1)
>> -        return;
>> +        return 0;
>>
>>      /* Create the lock file as the current user */
>>      if (lockfile && lockfile[0])
>> @@ -134,6 +214,8 @@ static void daemonize (const char *lockfile, char
>> *tty)
>>      }
>>
>>      /* Trap signals that we expect to receive */
>> +    signal (SIGINT, child_handler);
>> +    signal (SIGTERM, child_handler);
>>      signal (SIGCHLD, child_handler);
>>      signal (SIGUSR1, child_handler);
>>      signal (SIGALRM, child_handler);
>> @@ -152,9 +234,8 @@ static void daemonize (const char *lockfile, char
>> *tty)
>>
>>          /* Wait for confirmation from the child via SIGTERM or SIGCHLD,
>> or
>>             for two seconds to elapse (SIGALRM).  pause() should not
>> return. */
>> -        alarm (2);
>> +        alarm (5);
>
>
> Please correct the comment above, if you change the seconds.

Fixed. s/two/five

>>
>>          pause ();
>> -
>>          exit (EXIT_FAILURE);
>>      }
>> @@ -167,7 +248,8 @@ static void daemonize (const char *lockfile, char
>> *tty)
>>      signal (SIGTTOU, SIG_IGN);
>>      signal (SIGTTIN, SIG_IGN);
>>      signal (SIGHUP, SIG_IGN);    /* Ignore hangup signal */
>> -    signal (SIGTERM, SIG_DFL);    /* Die on SIGTERM */
>> +    signal (SIGINT, child_handler);
>> +    signal (SIGTERM, child_handler);
>>
>>      /* Change the file mode mask */
>>      umask (0);
>> @@ -182,7 +264,7 @@ static void daemonize (const char *lockfile, char
>> *tty)
>>      }
>>
>>      pFile = fopen (pidfile,"w");
>> -    if (pFile == NULL)
>> +    if (NULL == pFile)
>>      {
>>          syslog (LOG_ERR, "unable to create pid file %s, code=%d (%s)",
>>              pidfile, errno, strerror (errno));
>> @@ -201,36 +283,88 @@ static void daemonize (const char *lockfile, char
>> *tty)
>>      }
>>
>>      /* Redirect standard files to /dev/null */
>> -    freopen ("/dev/null", "r", stdin);
>> -    freopen ("/dev/null", "w", stdout);
>> -    freopen ("/dev/null", "w", stderr);
>> +    dummyFile = freopen ("/dev/null", "r", stdin);
>> +    dummyFile = freopen ("/dev/null", "w", stdout);
>> +    dummyFile = freopen ("/dev/null", "w", stderr);
>>
>>      /* Tell the parent process that we are A-okay */
>> -    kill (parent, SIGUSR1);
>> +    //kill (parent, SIGUSR1);
>
>
> Why do you uncomment this line than remove it?

Oliver?

>> + return parent;
>>  }
>>
>>  int main (int argc, char *argv[])
>>  {
>>      char *tty = NULL;
>> -    char ttypath[TTYPATH_LENGTH];
>>      char const *devprefix = "/dev/";
>>      char *name = NULL;
>>      char buf[IFNAMSIZ+1];
>> +    struct termios tios;
>> +    speed_t old_ispeed;
>> +    speed_t old_ospeed;
>> +
>> +    int opt;
>> +    int detach = 1;
>> +    int send_open = 0;
>> +    int send_close = 0;
>> +    int send_read_status_flags = 0;
>> +    char *speed = NULL;
>> +    char *uart_speed_str = NULL;
>> +    long int uart_speed = 0;
>> +    char *btr = NULL;
>> +    int run_as_daemon = 1;
>> +    pid_t parent_pid = 0;
>> +
>> +    ttypath[0] = '\0';
>> +
>> +    while ((opt = getopt(argc, argv, "ocfs:S:b:?hF")) != -1) {
>> +        switch (opt) {
>> +        case 'o':
>> +            send_open = 1;
>> +            break;
>> +        case 'c':
>> +            send_close = 1;
>> +            break;
>> +        case 'f':
>> +            send_read_status_flags = 1;
>> +            break;
>> +        case 's':
>> +            speed = optarg;
>> +            if (strlen(speed) > 1)
>> +                print_usage(argv[0]);
>> +            break;
>> +        case 'S':
>> +            uart_speed_str = optarg;
>> +            errno = 0;
>> +            uart_speed = strtol(uart_speed_str, NULL, 10);
>> +            if (errno)
>> +                print_usage(argv[0]);
>> +            break;
>> +        case 'b':
>> +            btr = optarg;
>> +            if (strlen(btr) > 6)
>> +                print_usage(argv[0]);
>> +            break;
>> +        case 'F':
>> +            run_as_daemon = 0;
>> +            break;
>> +        case 'h':
>> +        case '?':
>> +        default:
>> +            print_usage(argv[0]);
>> +            //exit(EXIT_SUCCESS);
>
>
> dito

Oliver?

>> + break;
>> +        }
>> +    }
>>
>>      /* Initialize the logging interface */
>>      openlog (DAEMON_NAME, LOG_PID, LOG_LOCAL5);
>>
>> -    /* See how we're called */
>> -    if (argc == 2) {
>> -        tty = argv[1];
>> -    } else if (argc == 3) {
>> -        tty = argv[1];
>> -        name = argv[2];
>> -        if (strlen(name) > IFNAMSIZ-1)
>> -            print_usage(argv[0]);
>> -    } else {
>> +    /* Parse serial device name and optional can interface name */
>> +    tty = argv[optind];
>> +    if(NULL == tty) {
>>          print_usage(argv[0]);
>>      }
>> +    name = argv[optind + 1];
>>
>>      /* Prepare the tty device name string */
>>      char * pch;
>> @@ -243,16 +377,69 @@ int main (int argc, char *argv[])
>>      syslog (LOG_INFO, "starting on TTY device %s", ttypath);
>>
>>      /* Daemonize */
>> -    daemonize ("/var/lock/" DAEMON_NAME, tty);
>> +    if(run_as_daemon) {
>> +        parent_pid = daemonize ("/var/lock/" DAEMON_NAME, tty, name);
>
>
> I think /var/lock is a perfect candidate for a define.

Oliver?

>> +    }
>> +    else {
>> +        /* Trap signals that we expect to receive */
>> +        signal (SIGINT, child_handler);
>> +        signal (SIGTERM, child_handler);
>> +    }
>> +
>> +    /* */
>> +    slcand_running = 1;
>>
>>      /* Now we are a daemon -- do the work for which we were paid */
>>      int fd;
>>      int ldisc = LDISC_N_SLCAN;
>>
>> -    if ((fd = open (ttypath, O_WRONLY | O_NOCTTY )) < 0) {
>> +    if ((fd = open (ttypath, O_RDWR | O_NONBLOCK | O_NOCTTY )) < 0) {
>>          syslog (LOG_NOTICE, "failed to open TTY device %s\n", ttypath);
>>          perror(ttypath);
>> -        exit(1);
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>> +    /* Configure baud rate */
>> +    memset(&tios, 0, sizeof(struct termios));
>> +    if(tcgetattr(fd, &tios) < 0) {
>> +    syslog (LOG_NOTICE, "failed to get attributes for TTY device %s:
>> %s\n", ttypath, strerror(errno));
>> +        exit (EXIT_FAILURE);
>> +    }
>> +
>> +    /* Get old values for later restore */
>> +    old_ispeed = cfgetispeed(&tios);
>> +    old_ospeed = cfgetospeed(&tios);
>> +
>> +    /* Baud Rate */
>> +    cfsetispeed(&tios, look_up_uart_speed(uart_speed));
>> +    cfsetospeed(&tios, look_up_uart_speed(uart_speed));
>> +
>> +    /* apply changes */
>> +    if(tcsetattr(fd, TCSADRAIN, &tios) < 0) {
>> +    syslog(LOG_NOTICE, "Cannot set attributes for device \"%s\": %s!\n",
>> ttypath, strerror(errno));
>> +    }
>> +
>> +    if (speed) {
>> +        sprintf(buf, "C\rS%s\r", speed);
>> +        if(write(fd, buf, strlen(buf)) < 0) {
>> +            //syslog (LO, "failed to get attributes for TTY device %s:
>> %s\n", ttypath, strerror(errno));
>> +
>> +        }
>> +    }
>> +
>> +    if (btr) {
>> +        sprintf(buf, "C\rs%s\r", btr);
>> +        write(fd, buf, strlen(buf));
>> +    }
>> +
>> +    if (send_read_status_flags) {
>> +        sprintf(buf, "F\r");
>> +        write(fd, buf, strlen(buf));
>> +    }
>> +
>> +    if (send_open) {
>> +        sprintf(buf, "O\r");
>> +        write(fd, buf, strlen(buf));
>>      }
>>
>>      /* set slcan like discipline on given tty */
>> @@ -289,14 +476,44 @@ int main (int argc, char *argv[])
>>              close(s);
>>          }
>>      }
>> +    if(parent_pid > 0) {
>> +        kill(parent_pid, SIGUSR1);
>> +    }
>>
>>      /* The Big Loop */
>> -    while (1) {
>> -        sleep(60); /* wait 60 seconds */
>> +    while (slcand_running) {
>> +        sleep(1); /* wait 1 second */
>> +    }
>> +
>> +    /* Reset line discipline */
>> +    syslog (LOG_INFO, "stopping on TTY device %s", ttypath);
>> +    ldisc = N_TTY;
>> +    if (ioctl (fd, TIOCSETD, &ldisc) < 0) {
>> +        perror("ioctl TIOCSETD");
>> +        exit(1);
>
>
> Is here a EXIT_FAILURE missing?

Oliver?

>> +    }
>> +
>> +    if (send_close) {
>> +        sprintf(buf, "C\r");
>> +        write(fd, buf, strlen(buf));
>>      }
>>
>> +    /* Reset old rates */
>> +    cfsetispeed(&tios, old_ispeed);
>> +    cfsetospeed(&tios, old_ospeed);
>> +
>> +    /* apply changes */
>> +    if(tcsetattr(fd, TCSADRAIN, &tios) < 0) {
>> +    syslog(LOG_NOTICE, "Cannot set attributes for device \"%s\": %s!\n",
>> ttypath, strerror(errno));
>> +    }
>> +
>> +    /* Remove pidfile */
>> +    if(run_as_daemon) {
>> +    unlink(pidfile);
>> +    }
>> +
>>      /* Finish up */
>>      syslog (LOG_NOTICE, "terminated on %s", ttypath);
>>      closelog ();
>> -    return 0;
>> +    return exit_code;
>>  }

Yegor
