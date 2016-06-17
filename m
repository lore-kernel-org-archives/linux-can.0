From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v5 4/5] can: bcm: add support for CAN FD frames
Date: Fri, 17 Jun 2016 15:35:27 +0200
Message-ID: <1466170528-10193-5-git-send-email-socketcan@hartkopp.net>
References: <1466170528-10193-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:24525 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933675AbcFQNfm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 09:35:42 -0400
In-Reply-To: <1466170528-10193-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The programming API of the CAN_BCM depends on struct can_frame which is
given as array directly behind the bcm_msg_head structure. To follow this
schema for the CAN FD frames a new flag 'CAN_FD_FRAME' in the bcm_msg_head
flags indicates that the concatenated CAN frame structures behind the
bcm_msg_head are defined as struct canfd_frame.

This patch adds the support to handle CAN and CAN FD frames on a per BCM-op
base. Main changes:

- generally use struct canfd_frames instead if struct can_frames
- use canfd_frame.flags instead of can_frame.can_dlc for private BCM flags
- make all CAN frame sizes depending on the new CAN_FD_FRAME flags
- separate between CAN and CAN FD when sending/receiving frames

Due to the dependence of the CAN_FD_FRAME flag the former binary interface
for classic CAN frames remains stable.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/bcm.h |   1 +
 net/can/bcm.c                | 223 ++++++++++++++++++++++++++-----------------
 2 files changed, 136 insertions(+), 88 deletions(-)

diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
index 7a291dc..cefb304 100644
--- a/include/uapi/linux/can/bcm.h
+++ b/include/uapi/linux/can/bcm.h
@@ -99,5 +99,6 @@ enum {
 #define RX_ANNOUNCE_RESUME  0x0100
 #define TX_RESET_MULTI_IDX  0x0200
 #define RX_RTR_FRAME        0x0400
+#define CAN_FD_FRAME        0x0800
 
 #endif /* !_UAPI_CAN_BCM_H */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index f3bf387..8e999ff 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1,7 +1,7 @@
 /*
  * bcm.c - Broadcast Manager to filter/send (cyclic) CAN content
  *
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * Copyright (c) 2002-2016 Volkswagen Group Electronic Research
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -67,27 +67,31 @@
  */
 #define MAX_NFRAMES 256
 
-/* use of last_frames[index].can_dlc */
+/* use of last_frames[index].flags */
 #define RX_RECV    0x40 /* received data for this element */
 #define RX_THR     0x80 /* element not been sent due to throttle feature */
-#define BCM_CAN_DLC_MASK 0x0F /* clean private flags in can_dlc by masking */
+#define BCM_CAN_FLAGS_MASK 0x3F /* to clean private flags after usage */
 
 /* get best masking value for can_rx_register() for a given single can_id */
 #define REGMASK(id) ((id & CAN_EFF_FLAG) ? \
 		     (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
 		     (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
 
-#define CAN_BCM_VERSION CAN_VERSION
+#define CAN_BCM_VERSION "20160617"
 
 MODULE_DESCRIPTION("PF_CAN broadcast manager protocol");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
 MODULE_ALIAS("can-proto-2");
 
-/* easy access to CAN frame payload */
-static inline u64 GET_U64(const struct can_frame *cp)
+/*
+ * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
+ * 64 bit aligned so the offset has to be multiples of 8 which is ensured
+ * by the only callers in bcm_rx_cmp_to_index() bcm_rx_handler().
+ */
+static inline u64 get_u64(const struct canfd_frame *cp, int offset)
 {
-	return *(u64 *)cp->data;
+	return *(u64 *)(cp->data + offset);
 }
 
 struct bcm_op {
@@ -101,13 +105,14 @@ struct bcm_op {
 	struct tasklet_struct tsklet, thrtsklet;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
 	int rx_ifindex;
+	int cfsiz;
 	u32 count;
 	u32 nframes;
 	u32 currframe;
-	struct can_frame *frames;
-	struct can_frame *last_frames;
-	struct can_frame sframe;
-	struct can_frame last_sframe;
+	struct canfd_frame *frames;
+	struct canfd_frame *last_frames;
+	struct canfd_frame sframe;
+	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
 };
@@ -136,7 +141,7 @@ static inline ktime_t bcm_timeval_to_ktime(struct bcm_timeval tv)
 	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
 }
 
-#define CFSIZ sizeof(struct can_frame)
+#define CFSIZ(flags) ((flags & CAN_FD_FRAME) ? CANFD_MTU : CAN_MTU)
 #define OPSIZ sizeof(struct bcm_op)
 #define MHSIZ sizeof(struct bcm_msg_head)
 
@@ -183,10 +188,16 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 		if (!op->frames_abs)
 			continue;
 
-		seq_printf(m, "rx_op: %03X %-5s ",
-			   op->can_id, bcm_proc_getifname(ifname, op->ifindex));
-		seq_printf(m, "[%u]%c ", op->nframes,
-			   (op->flags & RX_CHECK_DLC) ? 'd' : ' ');
+		seq_printf(m, "rx_op: %03X %-5s ", op->can_id,
+			   bcm_proc_getifname(ifname, op->ifindex));
+
+		if (op->flags & CAN_FD_FRAME)
+			seq_printf(m, "(%u)", op->nframes);
+		else
+			seq_printf(m, "[%u]", op->nframes);
+
+		seq_printf(m, "%c ", (op->flags & RX_CHECK_DLC) ? 'd' : ' ');
+
 		if (op->kt_ival1.tv64)
 			seq_printf(m, "timeo=%lld ",
 				   (long long)ktime_to_us(op->kt_ival1));
@@ -206,10 +217,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 	list_for_each_entry(op, &bo->tx_ops, list) {
 
-		seq_printf(m, "tx_op: %03X %s [%u] ",
-			   op->can_id,
-			   bcm_proc_getifname(ifname, op->ifindex),
-			   op->nframes);
+		seq_printf(m, "tx_op: %03X %s ", op->can_id,
+			   bcm_proc_getifname(ifname, op->ifindex));
+
+		if (op->flags & CAN_FD_FRAME)
+			seq_printf(m, "(%u) ", op->nframes);
+		else
+			seq_printf(m, "[%u] ", op->nframes);
 
 		if (op->kt_ival1.tv64)
 			seq_printf(m, "t1=%lld ",
@@ -246,7 +260,7 @@ static void bcm_can_tx(struct bcm_op *op)
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
-	struct can_frame *cf = &op->frames[op->currframe];
+	struct canfd_frame *cf = op->frames + op->cfsiz * op->currframe;
 
 	/* no target device? => exit */
 	if (!op->ifindex)
@@ -258,7 +272,7 @@ static void bcm_can_tx(struct bcm_op *op)
 		return;
 	}
 
-	skb = alloc_skb(CFSIZ + sizeof(struct can_skb_priv), gfp_any());
+	skb = alloc_skb(op->cfsiz + sizeof(struct can_skb_priv), gfp_any());
 	if (!skb)
 		goto out;
 
@@ -266,7 +280,7 @@ static void bcm_can_tx(struct bcm_op *op)
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
 
-	memcpy(skb_put(skb, CFSIZ), cf, CFSIZ);
+	memcpy(skb_put(skb, op->cfsiz), cf, op->cfsiz);
 
 	/* send with loopback */
 	skb->dev = dev;
@@ -289,13 +303,13 @@ out:
  *                    (consisting of bcm_msg_head + x CAN frames)
  */
 static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
-			     struct can_frame *frames, int has_timestamp)
+			     struct canfd_frame *frames, int has_timestamp)
 {
 	struct sk_buff *skb;
-	struct can_frame *firstframe;
+	struct canfd_frame *firstframe;
 	struct sockaddr_can *addr;
 	struct sock *sk = op->sk;
-	unsigned int datalen = head->nframes * CFSIZ;
+	unsigned int datalen = head->nframes * op->cfsiz;
 	int err;
 
 	skb = alloc_skb(sizeof(*head) + datalen, gfp_any());
@@ -306,18 +320,18 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 
 	if (head->nframes) {
 		/* CAN frames starting here */
-		firstframe = (struct can_frame *)skb_tail_pointer(skb);
+		firstframe = (struct canfd_frame *)skb_tail_pointer(skb);
 
 		memcpy(skb_put(skb, datalen), frames, datalen);
 
 		/*
-		 * the BCM uses the can_dlc-element of the CAN frame
+		 * the BCM uses the flags-element of the canfd_frame
 		 * structure for internal purposes. This is only
 		 * relevant for updates that are generated by the
 		 * BCM, where nframes is 1
 		 */
 		if (head->nframes == 1)
-			firstframe->can_dlc &= BCM_CAN_DLC_MASK;
+			firstframe->flags &= BCM_CAN_FLAGS_MASK;
 	}
 
 	if (has_timestamp) {
@@ -404,7 +418,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 /*
  * bcm_rx_changed - create a RX_CHANGED notification due to changed content
  */
-static void bcm_rx_changed(struct bcm_op *op, struct can_frame *data)
+static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 {
 	struct bcm_msg_head head;
 
@@ -416,7 +430,7 @@ static void bcm_rx_changed(struct bcm_op *op, struct can_frame *data)
 		op->frames_filtered = op->frames_abs = 0;
 
 	/* this element is not throttled anymore */
-	data->can_dlc &= (BCM_CAN_DLC_MASK|RX_RECV);
+	data->flags &= (BCM_CAN_FLAGS_MASK|RX_RECV);
 
 	head.opcode  = RX_CHANGED;
 	head.flags   = op->flags;
@@ -435,13 +449,13 @@ static void bcm_rx_changed(struct bcm_op *op, struct can_frame *data)
  *                          2. send a notification to the user (if possible)
  */
 static void bcm_rx_update_and_send(struct bcm_op *op,
-				   struct can_frame *lastdata,
-				   const struct can_frame *rxdata)
+				   struct canfd_frame *lastdata,
+				   const struct canfd_frame *rxdata)
 {
-	memcpy(lastdata, rxdata, CFSIZ);
+	memcpy(lastdata, rxdata, op->cfsiz);
 
 	/* mark as used and throttled by default */
-	lastdata->can_dlc |= (RX_RECV|RX_THR);
+	lastdata->flags |= (RX_RECV|RX_THR);
 
 	/* throttling mode inactive ? */
 	if (!op->kt_ival2.tv64) {
@@ -479,33 +493,36 @@ rx_changed_settime:
  *                       received data stored in op->last_frames[]
  */
 static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
-				const struct can_frame *rxdata)
+				const struct canfd_frame *rxdata)
 {
+	struct canfd_frame *cf = op->frames + op->cfsiz * index;
+	struct canfd_frame *lcf = op->last_frames + op->cfsiz * index;
+	int i;
+
 	/*
-	 * no one uses the MSBs of can_dlc for comparison,
+	 * no one uses the MSBs of flags for comparison,
 	 * so we use it here to detect the first time of reception
 	 */
 
-	if (!(op->last_frames[index].can_dlc & RX_RECV)) {
+	if (!(lcf->flags & RX_RECV)) {
 		/* received data for the first time => send update to user */
-		bcm_rx_update_and_send(op, &op->last_frames[index], rxdata);
+		bcm_rx_update_and_send(op, lcf, rxdata);
 		return;
 	}
 
 	/* do a real check in CAN frame data section */
-
-	if ((GET_U64(&op->frames[index]) & GET_U64(rxdata)) !=
-	    (GET_U64(&op->frames[index]) & GET_U64(&op->last_frames[index]))) {
-		bcm_rx_update_and_send(op, &op->last_frames[index], rxdata);
-		return;
+	for (i = 0; i < rxdata->len; i += 8) {
+		if ((get_u64(cf, i) & get_u64(rxdata, i)) !=
+		    (get_u64(cf, i) & get_u64(lcf, i))) {
+			bcm_rx_update_and_send(op, lcf, rxdata);
+			return;
+		}
 	}
 
 	if (op->flags & RX_CHECK_DLC) {
-		/* do a real check in CAN frame dlc */
-		if (rxdata->can_dlc != (op->last_frames[index].can_dlc &
-					BCM_CAN_DLC_MASK)) {
-			bcm_rx_update_and_send(op, &op->last_frames[index],
-					       rxdata);
+		/* do a real check in CAN frame length */
+		if (rxdata->len != lcf->len) {
+			bcm_rx_update_and_send(op, lcf, rxdata);
 			return;
 		}
 	}
@@ -555,7 +572,7 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 	/* if user wants to be informed, when cyclic CAN-Messages come back */
 	if ((op->flags & RX_ANNOUNCE_RESUME) && op->last_frames) {
 		/* clear received CAN frames to indicate 'nothing received' */
-		memset(op->last_frames, 0, op->nframes * CFSIZ);
+		memset(op->last_frames, 0, op->nframes * op->cfsiz);
 	}
 
 	return HRTIMER_NORESTART;
@@ -567,9 +584,11 @@ static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
 static inline int bcm_rx_do_flush(struct bcm_op *op, int update,
 				  unsigned int index)
 {
-	if ((op->last_frames) && (op->last_frames[index].can_dlc & RX_THR)) {
+	struct canfd_frame *lcf = op->last_frames + op->cfsiz * index;
+
+	if ((op->last_frames) && (lcf->flags & RX_THR)) {
 		if (update)
-			bcm_rx_changed(op, &op->last_frames[index]);
+			bcm_rx_changed(op, lcf);
 		return 1;
 	}
 	return 0;
@@ -634,15 +653,19 @@ static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
 static void bcm_rx_handler(struct sk_buff *skb, void *data)
 {
 	struct bcm_op *op = (struct bcm_op *)data;
-	const struct can_frame *rxframe = (struct can_frame *)skb->data;
+	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
 	unsigned int i;
 
-	/* disable timeout */
-	hrtimer_cancel(&op->timer);
-
 	if (op->can_id != rxframe->can_id)
 		return;
 
+	/* make sure to handle the correct frame type (CAN / CAN FD) */
+	if (skb->len != op->cfsiz)
+		return;
+
+	/* disable timeout */
+	hrtimer_cancel(&op->timer);
+
 	/* save rx timestamp */
 	op->rx_stamp = skb->tstamp;
 	/* save originator for recvfrom() */
@@ -673,13 +696,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 		 * multiplex compare
 		 *
 		 * find the first multiplex mask that fits.
-		 * Remark: The MUX-mask is stored in index 0
+		 * Remark: The MUX-mask is stored in index 0 - but only the
+		 * first 64 bits of the frame data[] are relevant (CAN FD)
 		 */
 
 		for (i = 1; i < op->nframes; i++) {
-			if ((GET_U64(&op->frames[0]) & GET_U64(rxframe)) ==
-			    (GET_U64(&op->frames[0]) &
-			     GET_U64(&op->frames[i]))) {
+			if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) ==
+			    (get_u64(op->frames, 0) &
+			     get_u64(op->frames + op->cfsiz * i, 0))) {
 				bcm_rx_cmp_to_index(op, i, rxframe);
 				break;
 			}
@@ -699,7 +723,8 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
 	struct bcm_op *op;
 
 	list_for_each_entry(op, ops, list) {
-		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex))
+		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
+		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME))
 			return op;
 	}
 
@@ -748,7 +773,8 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 	struct bcm_op *op, *n;
 
 	list_for_each_entry_safe(op, n, ops, list) {
-		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)) {
+		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
+		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
 
 			/*
 			 * Don't care if we're bound or not (due to netdev
@@ -794,7 +820,8 @@ static int bcm_delete_tx_op(struct list_head *ops, struct bcm_msg_head *mh,
 	struct bcm_op *op, *n;
 
 	list_for_each_entry_safe(op, n, ops, list) {
-		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)) {
+		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
+		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
 			list_del(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
@@ -835,6 +862,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 {
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
+	struct canfd_frame *cf;
 	unsigned int i;
 	int err;
 
@@ -861,19 +889,27 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* update CAN frames content */
 		for (i = 0; i < msg_head->nframes; i++) {
-			err = memcpy_from_msg((u8 *)&op->frames[i], msg, CFSIZ);
 
-			if (op->frames[i].can_dlc > 8)
-				err = -EINVAL;
+			cf = op->frames + op->cfsiz * i;
+			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
+
+			if (op->flags & CAN_FD_FRAME) {
+				if (cf->len > 64)
+					err = -EINVAL;
+			} else {
+				if (cf->len > 8)
+					err = -EINVAL;
+			}
 
 			if (err < 0)
 				return err;
 
 			if (msg_head->flags & TX_CP_CAN_ID) {
 				/* copy can_id into frame */
-				op->frames[i].can_id = msg_head->can_id;
+				cf->can_id = msg_head->can_id;
 			}
 		}
+		op->flags = msg_head->flags;
 
 	} else {
 		/* insert new BCM operation for the given can_id */
@@ -882,11 +918,13 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (!op)
 			return -ENOMEM;
 
-		op->can_id    = msg_head->can_id;
+		op->can_id = msg_head->can_id;
+		op->cfsiz = CFSIZ(msg_head->flags);
+		op->flags = msg_head->flags;
 
 		/* create array for CAN frames and copy the data */
 		if (msg_head->nframes > 1) {
-			op->frames = kmalloc(msg_head->nframes * CFSIZ,
+			op->frames = kmalloc(msg_head->nframes * op->cfsiz,
 					     GFP_KERNEL);
 			if (!op->frames) {
 				kfree(op);
@@ -896,10 +934,17 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			op->frames = &op->sframe;
 
 		for (i = 0; i < msg_head->nframes; i++) {
-			err = memcpy_from_msg((u8 *)&op->frames[i], msg, CFSIZ);
 
-			if (op->frames[i].can_dlc > 8)
-				err = -EINVAL;
+			cf = op->frames + op->cfsiz * i;
+			err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
+
+			if (op->flags & CAN_FD_FRAME) {
+				if (cf->len > 64)
+					err = -EINVAL;
+			} else {
+				if (cf->len > 8)
+					err = -EINVAL;
+			}
 
 			if (err < 0) {
 				if (op->frames != &op->sframe)
@@ -910,7 +955,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 			if (msg_head->flags & TX_CP_CAN_ID) {
 				/* copy can_id into frame */
-				op->frames[i].can_id = msg_head->can_id;
+				cf->can_id = msg_head->can_id;
 			}
 		}
 
@@ -945,8 +990,6 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 	/* check flags */
 
-	op->flags = msg_head->flags;
-
 	if (op->flags & TX_RESET_MULTI_IDX) {
 		/* start multiple frame transmission with index 0 */
 		op->currframe = 0;
@@ -980,7 +1023,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
 
-	return msg_head->nframes * CFSIZ + MHSIZ;
+	return msg_head->nframes * op->cfsiz + MHSIZ;
 }
 
 /*
@@ -1026,15 +1069,16 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (msg_head->nframes) {
 			/* update CAN frames content */
 			err = memcpy_from_msg((u8 *)op->frames, msg,
-					      msg_head->nframes * CFSIZ);
+					      msg_head->nframes * op->cfsiz);
 			if (err < 0)
 				return err;
 
 			/* clear last_frames to indicate 'nothing received' */
-			memset(op->last_frames, 0, msg_head->nframes * CFSIZ);
+			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
 		}
 
 		op->nframes = msg_head->nframes;
+		op->flags = msg_head->flags;
 
 		/* Only an update -> do not call can_rx_register() */
 		do_rx_register = 0;
@@ -1045,12 +1089,14 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (!op)
 			return -ENOMEM;
 
-		op->can_id    = msg_head->can_id;
-		op->nframes   = msg_head->nframes;
+		op->can_id = msg_head->can_id;
+		op->nframes = msg_head->nframes;
+		op->cfsiz = CFSIZ(msg_head->flags);
+		op->flags = msg_head->flags;
 
 		if (msg_head->nframes > 1) {
 			/* create array for CAN frames and copy the data */
-			op->frames = kmalloc(msg_head->nframes * CFSIZ,
+			op->frames = kmalloc(msg_head->nframes * op->cfsiz,
 					     GFP_KERNEL);
 			if (!op->frames) {
 				kfree(op);
@@ -1058,7 +1104,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			}
 
 			/* create and init array for received CAN frames */
-			op->last_frames = kzalloc(msg_head->nframes * CFSIZ,
+			op->last_frames = kzalloc(msg_head->nframes * op->cfsiz,
 						  GFP_KERNEL);
 			if (!op->last_frames) {
 				kfree(op->frames);
@@ -1073,7 +1119,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		if (msg_head->nframes) {
 			err = memcpy_from_msg((u8 *)op->frames, msg,
-					      msg_head->nframes * CFSIZ);
+					      msg_head->nframes * op->cfsiz);
 			if (err < 0) {
 				if (op->frames != &op->sframe)
 					kfree(op->frames);
@@ -1115,7 +1161,6 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 	} /* if ((op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex))) */
 
 	/* check flags */
-	op->flags = msg_head->flags;
 
 	if (op->flags & RX_RTR_FRAME) {
 
@@ -1187,7 +1232,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		}
 	}
 
-	return msg_head->nframes * CFSIZ + MHSIZ;
+	return msg_head->nframes * op->cfsiz + MHSIZ;
 }
 
 /*
@@ -1244,6 +1289,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct bcm_sock *bo = bcm_sk(sk);
 	int ifindex = bo->ifindex; /* default ifindex for this bcm_op */
 	struct bcm_msg_head msg_head;
+	int cfsiz;
 	int ret; /* read bytes or error codes as return value */
 
 	if (!bo->bound)
@@ -1258,7 +1304,8 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (ret < 0)
 		return ret;
 
-	if ((size - MHSIZ) % CFSIZ)
+	cfsiz = CFSIZ(msg_head.flags);
+	if ((size - MHSIZ) % cfsiz)
 		return -EINVAL;
 
 	/* check for alternative ifindex for this bcm_op */
@@ -1332,10 +1379,10 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	case TX_SEND:
 		/* we need exactly one CAN frame behind the msg head */
-		if ((msg_head.nframes != 1) || (size != CFSIZ + MHSIZ))
+		if ((msg_head.nframes != 1) || (size != cfsiz + MHSIZ))
 			ret = -EINVAL;
 		else
-			ret = bcm_tx_send(msg, ifindex, sk, CFSIZ);
+			ret = bcm_tx_send(msg, ifindex, sk, cfsiz);
 		break;
 
 	default:
-- 
2.8.1

