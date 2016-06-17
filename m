From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: build proc support only if CONFIG_PROC_FS is
 activated
Date: Fri, 17 Jun 2016 14:34:22 +0200
Message-ID: <5763EE4E.107@hartkopp.net>
References: <1466165326-29777-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:48436 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbcFQMe0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 08:34:26 -0400
In-Reply-To: <1466165326-29777-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc: Alexander Aring <aar@pengutronix.de>



On 06/17/2016 02:08 PM, Marc Kleine-Budde wrote:
> From: Alexander Aring <aar@pengutronix.de>
>
> When building can subsystem with CONFIG_PROC_FS=n I detected some unused
> variables warning by using proc functions. In CAN the proc handling is
> nicely placed in one object file. This patch adds simple add a
> dependency on CONFIG_PROC_FS for CAN's proc.o file and corresponding
> static inline no-op functions.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> [mkl: provide static inline noops instead of using #ifdefs]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
> Hello,
>
> picking up Alex's work. I've switched from #ifdef's to no-ops.
>
> regards,
> Marc
>
>   net/can/Makefile |  3 ++-
>   net/can/af_can.h | 11 +++++++++++
>   net/can/proc.c   |  3 +--
>   3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/net/can/Makefile b/net/can/Makefile
> index cef49eb1f5c7..10936754e3f2 100644
> --- a/net/can/Makefile
> +++ b/net/can/Makefile
> @@ -3,7 +3,8 @@
>   #
>
>   obj-$(CONFIG_CAN)	+= can.o
> -can-y			:= af_can.o proc.o
> +can-y			:= af_can.o
> +can-$(CONFIG_PROC_FS)	+= proc.o
>
>   obj-$(CONFIG_CAN_RAW)	+= can-raw.o
>   can-raw-y		:= raw.o
> diff --git a/net/can/af_can.h b/net/can/af_can.h
> index fca0fe9fc45a..38a79ff20022 100644
> --- a/net/can/af_can.h
> +++ b/net/can/af_can.h
> @@ -113,8 +113,19 @@ struct s_pstats {
>   extern struct dev_rcv_lists can_rx_alldev_list;
>
>   /* function prototypes for the CAN networklayer procfs (proc.c) */
> +#ifdef CONFIG_PROC_FS
>   void can_init_proc(void);
>   void can_remove_proc(void);
> +#else
> +static inline void can_init_proc(void)
> +{
> +	pr_info("can: Can't create /proc/net/can. CONFIG_PROC_FS missing!\n");
> +}
> +
> +static inline void can_remove_proc(void)
> +{
> +}
> +#endif
>   void can_stat_update(unsigned long data);
>
>   /* structures and variables from af_can.c needed in proc.c for reading */
> diff --git a/net/can/proc.c b/net/can/proc.c
> index 1a19b985a868..85ef7bb0f176 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -517,8 +517,7 @@ void can_init_proc(void)
>   	can_dir = proc_mkdir("can", init_net.proc_net);
>
>   	if (!can_dir) {
> -		printk(KERN_INFO "can: failed to create /proc/net/can . "
> -		       "CONFIG_PROC_FS missing?\n");
> +		pr_info("can: failed to create /proc/net/can.\n");
>   		return;
>   	}
>
>
