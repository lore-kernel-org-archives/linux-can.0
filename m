From: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Thu, 3 Jan 2019 15:01:21 +0100
Message-ID: <20190103140121.GB28932@unicorn.suse.cz>
References: <20190103122634.2530-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190103122634.2530-1-socketcan@hartkopp.net>
Sender: stable-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, ieatmuttonchuan@gmail.com, meissner@suse.de, linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Thu, Jan 03, 2019 at 01:26:34PM +0100, Oliver Hartkopp wrote:
> The CAN frame modification rules allow bitwise logical operations which can
> be also applied to the can_dlc field. Ensure the manipulation result to
> maintain the can_dlc boundaries so that the CAN drivers do not accidently
> write arbitrary content beyond the data registers in the CAN controllers
> I/O mem when processing can-gw manipulated outgoing frames. When passing these
> frames to user space this issue did not have any effect to the kernel or any
> leaked data as we always strictly copy sizeof(struct can_frame) bytes.
> 
> Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
> Reported-by: Marcus Meissner <meissner@suse.de>
> Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: linux-stable <stable@vger.kernel.org> # >= v3.2
> ---
>  net/can/gw.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index faa3da88a127..9000d9b8a133 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -418,6 +418,10 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>  
>  	/* check for checksum updates when the CAN frame has been modified */
>  	if (modidx) {
> +		/* ensure DLC boundaries after the different mods */
> +		if (cf->can_dlc > 8)
> +			cf->can_dlc = 8;
> +
>  		if (gwj->mod.csumfunc.crc8)
>  			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
>  

IMHO "8" should rather be "CAN_MAX_DLEN". I can see two problems with
your patch:

1. If I understand the code correctly, canfd_frame packets (which allow
larger lenth) are also processed by this code path.

2. Silently capping the DLC feels wrong, IMHO it would be cleaner to
drop the resulting packet if it's invalid.

This is the patch I came with:

From 8cc56bc825fa88803c08a8f85dc315bc112a8b05 Mon Sep 17 00:00:00 2001
From: Michal Kubecek <mkubecek@suse.cz>
Date: Thu, 3 Jan 2019 11:00:26 +0100
Subject: [PATCH] can: recheck dlc value of modified packet

CAN frame modification rules allow modification (set, and, or, xor) of DLC
(or payload length value). The new value is not checked against
CAN(FD)_MAX_DLEN so that indicated payload length may reach beyond actual
packet length.

As reported to security list, cgw_csum_xor_rel() with negative offset can
then rewrite e.g. frag_list pointer in skb_shared_info, crashing the
system. With unprivileged user namespaces, this can be exploited by any
regular user.

Rather than distinguishing between can_frame and canfd_frame, check if
resulting payload length does not reach beyond nskb->len which is what we
are actually interested in.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/can/gw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/can/gw.c b/net/can/gw.c
index faa3da88a127..87b7043e3250 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -418,6 +418,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 	/* check for checksum updates when the CAN frame has been modified */
 	if (modidx) {
+		int max_dlc = nskb->len - offsetof(struct can_frame, data);
+
+		/* dlc may have changed, check the new value */
+		if (cf->can_dlc > max_dlc) {
+			gwj->dropped_frames++;
+			kfree_skb(nskb);
+			return;
+		}
+
 		if (gwj->mod.csumfunc.crc8)
 			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
 
-- 
2.20.1
