From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] slcanpty
Date: Sat, 08 Jun 2013 13:09:16 +0200
Message-ID: <51B310DC.8040509@hartkopp.net>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2> <51B0D58F.2010401@hartkopp.net> <6f9fdd56db06e6029218834c526f7d15@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:38504 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab3FHLJS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Jun 2013 07:09:18 -0400
In-Reply-To: <6f9fdd56db06e6029218834c526f7d15@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: janusz.uzycki@elproma.com.pl
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

Hi Janusz,

thanks for the patch.

I changed it in the way the perror() is only called on negative return values.

Please check it out for a test.

Best regards,
Oliver

On 07.06.2013 15:40, janusz.uzycki@elproma.com.pl wrote:
> Hi Oliver.
> 
> I've tested the following case:
> modprobe vcan
> ip link add dev vcan0 type vcan
> #ip link set vcan0 up type can bitrate 125000
> ip link set vcan0 up
> socat PTY,link=/tmp/a -
> cgdb --args ./slcanpty /tmp/a vcan0
> 
> If socat killed slcanpty should finish instead of crazy loop (select always
> returns).
> Here is proposal of very little patch:
> From a708491ea49e170ac1d36148e75b7b6c6f07b6fd Mon Sep 17 00:00:00 2001
> From: Janusz Uzycki <j.uzycki@elproma.com.pl>
> Date: Fri, 7 Jun 2013 15:25:39 +0200
> Subject: slcanpty: detect that master PTY descriptor closed
> 
> 
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> ---
>  slcanpty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/slcanpty.c b/slcanpty.c
> index f3628b9..061c1ab 100644
> --- a/slcanpty.c
> +++ b/slcanpty.c
> @@ -75,7 +75,7 @@ int pty2can(int pty, int socket, struct can_filter *fi,
>         int tmp, i;
> 
>         nbytes = read(pty, &buf, sizeof(buf)-1);
> -       if (nbytes < 0) {
> +       if (nbytes <= 0) { /* 0 means that master PTY descriptor has been
> closed */
>                 perror("read pty");
>                 return 1;
>         }
> -- 
> 1.7.11.3
> 
> best regards
> Janusz
> 

