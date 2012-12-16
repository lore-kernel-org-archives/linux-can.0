From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Patch] can-utils/slcanpty.c pseudo-terminal interface
Date: Sun, 16 Dec 2012 17:02:12 +0100
Message-ID: <50CDF084.8030002@hartkopp.net>
References: <50564EC7.7020005@myvdr.de> <5056D3F7.10506@pengutronix.de> <50CBCEF2.9020904@myvdr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:25906 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab2LPQCQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Dec 2012 11:02:16 -0500
In-Reply-To: <50CBCEF2.9020904@myvdr.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: uescher <linux-can_ger.kernel.org@myvdr.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Please re-send with proper whitespaces.

Something (your mail client?) replaced tabs with spaces ...

@Marc: If there're new no remarks from your side you can add my

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

for the re-posted patch.

Tnx Ulrich for the pts support!

Regards,
Oliver

On 15.12.2012 02:14, uescher wrote:

> Next try :)
> Add Support for the Unix 98 pseudo-terminal interface /dev/ptmx /dev/pts/N
> http://www.kernel.org/doc/man-pages/online/pages/man4/pts.4.html
> My change is like this change:
> http://sourceforge.net/tracker/index.php?func=detail&aid=3467521&group_id=146269&atid=764681
> 
> most Linux distributions do not configure their kernels to use the BSD
> pseudo-terminal interface (/dev/pty* and /dev/tty*) anymore; they uses the
> Unix 98 pseudo-terminal interface instead (/dev/ptmx and /dev/pts/*).
> Maybe is it possible to add this patch for the next release.
> Thanks.
> 
> Signed-off-by: Ulrich Escher<git@myvdr.de>
> ---
>  slcanpty.c |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/slcanpty.c b/slcanpty.c
> index 67a7491..13ed96c 100644
> --- a/slcanpty.c
> +++ b/slcanpty.c
> @@ -22,6 +22,9 @@
>   *
>   */
> 
> +/* To get ptsname grantpt and unlockpt definitions from stdlib.h */
> +#define _GNU_SOURCE
> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -40,6 +43,7 @@
> 
>  /* maximum rx buffer len: extended CAN frame with timestamp */
>  #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
> +#define DEVICE_NAME_PTMX "/dev/ptmx"
> 
>  #define DEBUG
> 
> @@ -383,6 +387,8 @@ int main(int argc, char **argv)
>          fprintf(stderr, "Usage: %s <pty> <can interface>\n", argv[0]);
>          fprintf(stderr, "e.g. '%s /dev/ptyc0 can0' creates"
>              " /dev/ttyc0 for the slcan application\n", argv[0]);
> +        fprintf(stderr, "e.g. for pseudo-terminal '%s %s can0' creates"
> +            " /dev/pts/N\n", argv[0], DEVICE_NAME_PTMX);
>          fprintf(stderr, "\n");
>          return 1;
>      }
> @@ -404,6 +410,27 @@ int main(int argc, char **argv)
>                 ECHONL | ECHOPRT | ECHOKE | ICRNL);
>      tcsetattr(p, TCSANOW, &topts);
> 
> +    /* Support for the Unix 98 pseudo-terminal interface /dev/ptmx /dev/pts/N */
> +    if  (strcmp(argv[1], DEVICE_NAME_PTMX) == 0) {
> +        if (grantpt(p) < 0) {
> +            perror("grantpt");
> +            return 1;
> +        }
> +
> +        if (unlockpt(p) < 0) {
> +            perror("unlockpt");
> +            return 1;
> +        }
> +
> +        char *name_pts = NULL;    /* slave pseudo-terminal device name */
> +        name_pts = ptsname(p);
> +        if (name_pts == NULL) {
> +            perror("ptsname");
> +            return 1;
> +        }
> +        printf("open: %s: slave pseudo-terminal is %s\n", argv[1], name_pts);
> +    }
> +
>      /* open socket */
>      s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>      if (s < 0) {
> -- 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


