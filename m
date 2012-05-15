From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC v3] CAN FD support
Date: Tue, 15 May 2012 11:19:33 +0200
Message-ID: <4FB21FA5.8080807@hartkopp.net>
References: <4FAD5A04.2030108@hartkopp.net> <20120514093630.GA600@vandijck-laurijssen.be> <4FB16213.2000007@hartkopp.net> <20120515083454.GA504@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:47489 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758518Ab2EOJTd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 May 2012 05:19:33 -0400
In-Reply-To: <20120515083454.GA504@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 15.05.2012 10:34, Kurt Van Dijck wrote:

> On Mon, May 14, 2012 at 09:50:43PM +0200, Oliver Hartkopp wrote:

>> A legacy application wants to communicate via can0 not knowing anything about
>> CAN FD. This legacy app can only read and write struct can_frames and does not
>> know about different data rates in the data field.
>>
>> 1. For this scenario we need to define (globally!?) if legacy apps generated
>> (short) CAN frames use the slow or high data rate in the data field when
>> transmitted via that specific CAN FD interface.
> IMHO, slow datarate matches the most closely to regular CAN2.0B.


You can not rely on this.

The most probable migration scenario is to increase the payload data rate
without changing any application.

>>
>> 2. in any case legacy applications must not get CAN frames with a DLC > 8
> Or cut the DLC to 8, and drop the remainder of the message? This changes
> the actual can(fd)_frame. That is acceptable since you're running legacy apps
> on CANFD bus.
> 
> An alternative could be to drop CANFD frames in can_recv() itself.
> This may sound inefficient, but remind you're running legacy apps on CANFD busses
> _WITH_ CANFD frames on it.


I have a patch for that later in this mail.

> 
> I'd rather choose a suboptimal compatibility mode than adding code to explicitely
> tweak the subsystem.


CAN_RAW_FD_FRAMES *is* this compatibility switch :-)

>>
>> 3. legacy applications assume struct can_frames on read and write. There
>> should no MSG_TRUNC been set in msg flags when receiving a can_frame.
> see 2. MSG_TRUNC would be set only with sizes != CAN_MTU & != CANFD_MTU.
> 
> This level of compatibility involves modifying the actual received CAN frame
> when CANFD frames are received on a socket using CAN_MTU. I accept this
> compatibility for sake of preserving the API that DLC <= 8 for such frames.


Yes. I did exactly this in my patch this morning.

If you get a CANFD frame to be passed to a legacy socket

1. check id DLC <= 8 (in raw_rcv())
2. cut the length from CANFD_MTU to CAN_MTU (in raw_recvmsg())

> 
>>
>> OTOH we will have new applications that are aware of CAN FD. These new
>> applications may also be able to deal with two different sizes of structs for
>> read and write operations (can_frame and canfd_frame) - if we specify it so.
> they (ideally) always do:
> 	ret = recv(cansock, &canfd_frame, CANFD_MTU);
> and recv() returns CANFD_MTU _or_ CAN_MTU.
> That sounds acceptible.


Yes. IMO we can specify that the new CANFD aware applications have to deal
with both MTUs. But we can not demand this from legacy apps.


>> Beware of providing a needless flexibility here.
>> Once the CAN driver is switched to the CAN FD mode you can send and receive
>> all types of frames. You can send normal CAN frames inside struct canfd_frame
>> too! So when you open a socket - and you are a CAN FD aware app - you switch
>> to CAN_RAW_FD_FRAMES and you are free to send/recv whatever you like.
> Now this is interesting. I really tought that a struct can_frame and a
> struct canfd_frame with similar content still produce a (slight) different
> bitstream on the wire, i.e. a struct can_frame would produce a CAN2.0b bitstream
> that is different than the CANFD bitstream.
> 
> I did think that this difference in bitstream/protocol would map
> on a different struct.
> Where am I wrong here?


Yes. You get a different bitstream.

When you send a canfd_frame you can set the EDL bit and specify a length of
8 bytes which is different to a legacy can_frame without the EDL bit.

> 
> Even if I'm not convinced, I now better understand your exclusive-or ...
> This definitely needs clarification.


Yes. Especially we need to specify how the CAN controller should send
can_frames passed to its CAN driver. Should it been send with or without
EDL bit, and should it been send with high data rate or not.

This is what i wanted to suggest with the global CANFD driver settings.

(..)

> 
> Even that I avoided this 0.001% difference above in (2.), I'll still
> make a nasty comparison here.
> 
> If an ABI was 100% the same, I argue that if a legacy app does
> 	int value = 1;
> 	setsockopt(cansock, 5, &value, sizeof(value));
> Then you also are changing the behaviour of the legacy application now.


This is indeed nasty.
A legacy application would never have executed using an undefined sockopt.
So this has nothing to do with backwards compatibility. It's simply broken.

> No problem, let's create CANFD_RAW. But even that is not 100% compatible.
> 
> Ok, this is unlikely to be a problem, but 'unlikely' > 0%.
> You see my point? A legacy app doing
> 	recv(cansock, &can_frame, <CANFD_MTU hardcoded>);
> may break legacy apps, but this is considered unlikely, and
> such crap should not prevent development of good stuff.
> 
> Just think about it.


Done :-)

Legacy crap that was technically possible to do just has to be supported.

Here's my patch:

Changes to the previous version:

CANFD aware apps set CAN_RAW_FD_FRAMES to enable longer MTUs (not new).

1. CANFD aware apps may get CAN_MTU and CANFD_MTU frames on rx
2. CANFD aware apps may send CAN_MTU and CANFD_MTU frames on tx
3. legacy apps can receive CAN_MTU and CANFD_MTU frames if the DLC <= 8
   (the possible CANFD_MTU is cut down to CAN_MTU to preserve the ABI)

Effects to the CAN netdev driver:

Legacy operation (CAN_MTU)
- send and receive struct can_frames

CANFD operation (CANFD_MTU and CAN_MTU)
- you can send CANFD_MTU and CAN_MTU frames
  (a default setting (EDL, HDR) for CAN_MTU frames needs to be specified)
- the driver generates always canfd_frames on reception


diff --git a/net/can/raw.c b/net/can/raw.c
index f298707..a20ee8e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -120,12 +120,11 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
-	/* only pass correct frames to the socket */
-	if (ro->fd_frames) {
-		if (unlikely(oskb->len != CANFD_MTU))
-			return;
-	} else {
-		if (unlikely(oskb->len != CAN_MTU))
+	/* do not pass frames with DLC > 8 to a legacy socket */
+	if (!ro->fd_frames) {
+		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
+
+		if (unlikely(cfd->len > CAN_MAX_DLEN))
 			return;
 	}
 
@@ -696,7 +695,7 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
 		ifindex = ro->ifindex;
 
 	if (ro->fd_frames) {
-		if (unlikely(size != CANFD_MTU))
+		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
 			return -EINVAL;
 	} else {
 		if (unlikely(size != CAN_MTU))
@@ -752,7 +751,9 @@ static int raw_recvmsg(struct kiocb *iocb, struct socket *sock,
 		       struct msghdr *msg, size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
+	struct raw_sock *ro = raw_sk(sk);
 	struct sk_buff *skb;
+	int rxmtu;
 	int err = 0;
 	int noblock;
 
@@ -763,10 +764,20 @@ static int raw_recvmsg(struct kiocb *iocb, struct socket *sock,
 	if (!skb)
 		return err;
 
-	if (size < skb->len)
+	/*
+	 * when serving a legacy socket the DLC <= 8 is already checked inside
+	 * raw_rcv(). Now check if we need to pass a canfd_frame to a legacy
+	 * socket and cut the possible CANFD_MTU/CAN_MTU length to CAN_MTU
+	 */
+	if (!ro->fd_frames)
+		rxmtu = CAN_MTU;
+	else
+		rxmtu = skb->len;
+
+	if (size < rxmtu)
 		msg->msg_flags |= MSG_TRUNC;
 	else
-		size = skb->len;
+		size = rxmtu;
 
 	err = memcpy_toiovec(msg->msg_iov, skb->data, size);
 	if (err < 0) {

