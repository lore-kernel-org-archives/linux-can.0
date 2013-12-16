From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC] WIP-patches on sllin
Date: Mon, 16 Dec 2013 08:46:17 +0100
Message-ID: <2633616.0o8t6AGOQY@ws-stein>
References: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com> <201312130200.18981.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:40426 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095Ab3LPHry (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:47:54 -0500
In-Reply-To: <201312130200.18981.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Rostislav =?ISO-8859-1?Q?Lisov=FD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org

Hello pavel,

On Friday 13 December 2013 02:00:18, Pavel Pisa wrote:
> On Tuesday 10 of December 2013 18:16:11 Alexander Stein wrote:
> > I'm currently working with sllin (LIN based on socketcan) from
> > git://rtime.felk.cvut.cz/linux-lin.git /
> > https://rtime.felk.cvut.cz/gitweb/linux-lin.git/shortlog. Up to now master
> > is working pretty well and I fixed a bug for slave node (patch 5). I'm
> > currently working on LIN slave task on slave node which was unimplemented
> > up to now.
> 
> first I want to express my happines that our work is
> getting tested/used. This allows to check if concept fits needs
> of more users and if it is confirmed we can start to speak
> about move to the mainline (linux/drivers/staging or net/can)

I think staging is currently the only acceptable place for sllin. But I don't know to handle 
> #define N_SLLIN			25
in that case. I guess even for staging, this line discipline number must be reserved.

> I have pushed next patches to our repository
> 
>   sllin: Replace pr_* with netdev_* where approriate
>   sllin: Make local functions static
>   sllin: slave: don't forget to wait for the checksum

Thanks for taking them.

> I would like to think and discuss little about the rest
> 
> > This first version uses the slave cache for message sending when requested,
> > but so it is no longer possible to configure the length for specific
> > message IDs which are only recweived. The LIN_CACHE_RESPONSE bit is used up
> > to now to configure the data length (DLC) of receptions in slave mode. This
> > doesn't work anymore when slave responses to configured IDs.
> > Are there any comments to distinguish between configured for sending and
> > configured for reception only? I tried to avoid addig a new bit for that,
> > but didn't find any idea for that.
> > I still would acknowledge comments on the other patches.
> 
> There was much more rich set of the flags in original code design
> 
>   /* Save configuration for particular LIN ID */
>   #define LIN_ID_CONF		(1 <<  LIN_CANFR_FLAGS_OFFS)
>   /* Publisher of particular LIN response is SLLIN Master */
>   #define LIN_SRC_MASTER		(1 << (LIN_CANFR_FLAGS_OFFS + 1))
>   #define LIN_SRC_SLAVE		(1 << (LIN_CANFR_FLAGS_OFFS + 2))
>   #define LIN_SLAVE_LOCAL		(1 << (LIN_CANFR_FLAGS_OFFS + 3))
>   #define LIN_SLAVE_REMOTE	(1 << (LIN_CANFR_FLAGS_OFFS + 4))
>   #define LIN_LOC_SLAVE_CACHE	(1 << (LIN_CANFR_FLAGS_OFFS + 5))
>   #define LIN_CHECKSUM_EXTENDED	(1 << (LIN_CANFR_FLAGS_OFFS + 6))
>  
>   #define LIN_ERR_RX_TIMEOUT	(1 << (LIN_CANFR_FLAGS_OFFS + 7))
>   #define LIN_ERR_CHECKSUM	(1 << (LIN_CANFR_FLAGS_OFFS + 8))
>   #define LIN_ERR_FRAMING		(1 << (LIN_CANFR_FLAGS_OFFS + 9))
> 
> but it was reduced to make life easier for users in one of the
> final project clenup commit
> 
>   sllin: Flags clean up
> 
> and it seems that the set was oversimplified. One option is to
> consider each cache location as setup when sl->linfr_cache[lin_id].dlc != 0
> or we need to reintroduce back concept of LIN_LOC_SLAVE_CACHE.
> I am not sure if zero length messages are disallowed by standard.
> But if they are then dlc!=0 is reasonable choice. My personal
> is many flags but I tend to too generic solutions usually as you
> can in original flags support.

I've reread LIN-Spec_2-2A.pdf section "2.3.1.4 Data" where the first sentence states:
> "A frame carries between one and eight bytes of data."
So a dlc of 0 is invalid. This is the reason I picked that as an indicator for known length or not.

> It has still one drawback if we decide to store received data
> for IDs with unknown length in the frame cache for later retrieval
> by local application. This can be resolved by re-addition of another
> flag.

Is storing in the cache for later retrieval actual necessary? Sure, you currently need a socket for LIN frame reception.

> Without the flag, I propose next chages
> 
> 
> diff --git a/sllin/sllin.c b/sllin/sllin.c
> index b97219e..12dce59 100644
> --- a/sllin/sllin.c
> +++ b/sllin/sllin.c
> @@ -549,7 +549,7 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
>                         spin_lock_irqsave(&sl->linfr_lock, flags);
> 
>                         /* Is the length of data set in frame cache? */
> -                       if (sce->frame_fl & LIN_CACHE_RESPONSE) {
> +                       if (sce->dlc > 0) {
>                                 sl->rx_expect += sce->dlc + 1; /* + checksum */
>                                 sl->rx_len_unknown = false;
>                         } else {

I also created this one.

> And appropriate change in the user space configuration utility
> 
> diff --git a/lin_config/src/sllin_config.c b/lin_config/src/sllin_config.c
> index dc704d8..757046b 100644
> --- a/lin_config/src/sllin_config.c
> +++ b/lin_config/src/sllin_config.c
> @@ -123,7 +123,6 @@ int sllin_cache_config(struct linc_lin_state *linc_lin_state,
>         }
> 
>         for (i = 0; i < 0x3F; i++) {
> -               if (linc_lin_state->frame_entry[i].status == 1) { /* Is active */
>                         frame.can_dlc = linc_lin_state->frame_entry[i].data_len;
>                         frame.can_id = i; /* LIN ID */
>                         frame.data[0] = linc_lin_state->frame_entry[i].data[0]; /* Data */
> @@ -134,13 +133,14 @@ int sllin_cache_config(struct linc_lin_state *linc_lin_state,
>                         frame.data[5] = linc_lin_state->frame_entry[i].data[5]; /* Data */
>                         frame.data[6] = linc_lin_state->frame_entry[i].data[6]; /* Data */
>                         frame.data[7] = linc_lin_state->frame_entry[i].data[7]; /* Data */
> -
> -                       frame.can_id |= LIN_CTRL_FRAME | LIN_CACHE_RESPONSE;
> +                       frame.can_id |= LIN_CTRL_FRAME;
> +               if (linc_lin_state->frame_entry[i].status == 1) { /* Is active */
> +                       frame.can_id |= LIN_CACHE_RESPONSE;
> +               }
>                         ret = write(s, &frame, sizeof(frame));
>                         printf("configuring frame cache; ret = %d\n", ret);
>                         //if (ret ...)
>                         //read_response(tty);
> -               }
>         }
> 
>         close(s);
> 
> The use of dlc == 0 allows still to disable entry and I propose clear unconfigured
> entries to do full reconfiguration when tool is called.
> 
> If you agree with above solution or propose to use new flag I prepare and commit
> the patch.

I don't use sllin_config, so I can't comment much on that. But from your comments it sound reasonable.

> To your additional patches, I need a little refresh of my information
> to review slave functionality and there is a must for communication
> with UART maintainers because without at least minor changes in FIFO
> control it cannot work reliably.

Yep, I'm aware of that. sllin in slave currently required an FIFO Rx (or even DMA) interrupt when a single character is received. Luckily the driver I'm currently working on (imx.c) does that out-of-the-box.

> Some comments
> 
>   sllin: reorder functions
>        generally I am not opposed to the change but there are things to consider
>           initial order tries keep lower level UART manipulation functions first
>           to allow future extending the code to part specific to UART/TTY and more
>           generic LIN code reusable even with LIN direct hardware support.
>           But I agree that things has got mixed already due to checking for some
>           LIN specific data in generic UART part and UART processing considerations
>           in LIN protocol specific code.

Putting function together which do some related stuff is fine. I reordered them to avoid additional declarations at the beginning, like many drivers do. But I'm fine with keeping the "old" order.

>   sllin: If length is unknown read until timer occurs or break is received
>        probably the best thing to do in general. The use of Rx FIFO timeouts
>        of some UARTS can be used there. It worked on PC for us but it is
>        not robust. I would like to analyze little more the code to ensure
>        that locking stay correct after your change.
> 
>   sllin: Add first support for LIN slave task on slave node
>       it is possible that we do not need worker thread for the slave at all.
>       The data can be prepared in UART callback processing. I believe
>       we have it working that way at least in one of code versions.
>       But slave was declared not to be implemented in the last version.
>       On the other hand, use of the worker thread is more polite to other
>       kernel services. There has been attempt for minimal locking between
>       UART specific part and the worker thread because UART callbacks
>       are invoked in many different even curious contexts according to
>       serial port HW and kernel - RT in IRQ threads, vanilla usually BH
>       but may be even hard IRQ for some arch, worker threads for USB devices
>       etc.

My patchset has enlarged meanwhile which fixes some problems I noticed or even adds more features.

> Anyway thanks for your contribution and I hope that we move project
> at least a little forward.

As I'm currently not working on sllin I think I'll send my current patchset (based on your new master). It is not cleaned up 8e.g. patches fixing things added in other patches), but it LIN slave worked pretty well with that. Mh, maybe I should get a github/gitorious account...
Oh, I started "creating" lindump (obviously copied from candump) for easier LIN frame reading. Not perfect and lots of candump leftovers, but fits my current needs and "works for me" :)

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

