Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704232;
	b=vQRX1WkJPCTXHDJIasajTzaMQ2NX98wgaZVjAPv7L5rk3J82Mq1p+ofzCsR8/l9MmtEj
	 4D9TqF/crk7MhR/dlACss659oG2WrhaTXVIUu2nlXTzaYQ8MJGchUvWeRg7wKLdALqFDP
	 Xekv0cgdXF9XasVWUV5BPcmJ6crq5vjP2asZu08gxqX7XfSe7g1gXF0i7Jm3fAA+8CAYw
	 96tmc1ZsODPe57e9TrrMOODyqldK3lKKhzsZf5Bb+i4zVVvBKIO4CpT09Qt6H7T4uaQIZ
	 1LsOwSEpwf1amjOKoXHFAO/jOJMRP5IHgdcNAijUFxQSgNEUhCxqa918Lxn4nXy/49A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704232;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8SuJLFCCMICMnCq7/JDFAMRW0z2sJPv2n6HFGIfofB8=;
	b=BLdq92m6cXlJpF64Q6N6JFEdPsNFDIgrDCH7wr6YNF7O1HeqHfGd5ZOQwGWYul87gdzN
	 XrKmO6qNWB7TPjv0GhmhfJnIXmWsCC5kVtxEk9cjO8OBaXv4/jsoB/dW7zMNNvmmpRHZE
	 CWbqe19sQ7UmJvZFzKF94+vELPez/uHmZCQHMZGUcViDDPQEliDO7nileIdYnkI3sptCF
	 xlziuRpG2pB6tVtxIZDUcLs36oWsIWwKNm7D49etwfRq+esnLwYl78PyINcKc4cJKeKSZ
	 iPl/Gr0V5bCwlBLAs/EYu+tmrdmdc4z7mh8uKHRAfduflLMOtoaWGw+gC4ClJACdmcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAs0utpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6A606A329
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAs0utpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303221F000C5;
	Sun, 15 Nov 2026 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704231;
	bh=8SuJLFCCMICMnCq7/JDFAMRW0z2sJPv2n6HFGIfofB8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GAs0utpyw4l2AcUAW9O14Bct0YWUPE1zgi8F8sVr/LjwDeqJE8y6gKiiDg69AvUF9
	 DBZzsssz/qdjTiRuo0d+iLFaS2DKf7wL1bbjJebhs7mMq8jeDFkXlRrfiTX6aMphXi
	 1jyQTSPuIjYiMn9224LF4nu4c9AG4biRc6A1M6KqbH7Auzp7JSyLk8i+71gz2u/aMw
	 LR5BIlSODArcCQTcci9DJwUG4dSd75vAtaHZQ7t9IjvmxYm43c36nRQW2oh1vZPfbk
	 cdWzRmfsuKEQTZbdKIDN88lckuwi36GinZQS+Kiq6IvjiqZ0RdxDvuvCVXnq26vnEB
	 gN6enp4P4CqKg==
Subject: Re: [PATCH can-next v4 3/3] can: add can diag interface
From: netdev-bot+sashiko@kernel.org
To: fstornio@redhat.com
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, robin@protonic.nl,
 o.rempel@pengutronix.de, kernel@pengutronix.de, urs.thuermann@volkswagen.de,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 dcaratti@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 00:57:10 +0000
Message-ID: <179470423073.488853.9698252872794929358@kernel.org>
In-Reply-To: <20261113-feat-can-diag-v4-3-c28842c74c95@redhat.com>
References: <20261113-feat-can-diag-v4-3-c28842c74c95@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] can_diag_dump() holds the per-netns mutex net->can.sklist_lock
  while it walks the socket list.
- [High] Use-after-free of sk->sk_socket in sk_diag_fill() after a
  socket-creation / protocol-module-unload race.
- [Medium] can_diag_dump() (net/can/diag.c:129-158) resumes a multi-part
  dump by position: it stores only the integer index in cb->args[0] =…
- [Medium] The new uAPI request struct can_diag_req
  (include/uapi/linux/can/diag.h:11-19) exports cdiag_states, cdiag_ino,…
- [Medium] can_diag_msg.cdiag_state is filled from sk->sk_state
  (net/can/diag.c:51), but no CAN protocol ever writes sk_state.
- [Medium] The commit message says the response includes 'the interface
  index for bound sockets', but CAN_BCM sockets connected to an…
- [Medium] struct can_diag_req reuses the name sdiag_protocol at a
  different offset and width from the generic struct sock_diag_req.
- [Low] CONFIG_CAN_DIAG is introduced with 'default m'
  (net/can/Kconfig:73-80).

--

can: add can diag interface

This adds a SOCK_DIAG handler for AF_CAN so that ss(8) can list open CAN
sockets. A new uAPI header defines the request and response structs and a
few protocol specific netlink attributes. can_diag_dump() walks the
per-netns CAN socket list while holding sklist_lock.

> diff --git a/include/uapi/linux/can/diag.h b/include/uapi/linux/can/diag.h
> new file mode 100644
> index 0000000000000..f22103e7bf902
> --- /dev/null
> +++ b/include/uapi/linux/can/diag.h
> @@ -0,0 +1,50 @@

[ ... ]

> +/* Request */
> +struct can_diag_req {
> +	__u8	sdiag_family;	/* must be AF_CAN */
> +	__u8	pad;
> +	__u16	sdiag_protocol; /* for future filtering of transport protocols */

[Severity: Medium]

Is it intended that sdiag_protocol has a different offset and width here
than in the generic header?

include/uapi/linux/sock_diag.h:
struct sock_diag_req {
	__u8	sdiag_family;
	__u8	sdiag_protocol;
};

In can_diag_req, byte 1 is a pad that is never checked, and
sdiag_protocol is a __u16 at offset 2. Other per-family requests, such as
inet_diag_req_v2, keep the generic prefix.

A caller might fill in the common sock_diag_req prefix and set byte 1 to
CAN_RAW, CAN_ISOTP or CAN_J1939 for the advertised future filtering. That
value lands in can_diag_req.pad. can_diag_handler_dump() only rejects a
nonzero u16 at offset 2, so the selector is silently ignored and every
socket is returned.

CAN_NPROTO is 8, so would a __u8 sdiag_protocol at offset 1 be enough?
Also, since pad is not checked today, it cannot be given a meaning later
without breaking existing callers.

> +	__u32	cdiag_states;
> +	__u32	cdiag_ino;
> +	__u32	cdiag_show;
> +	__u32	cdiag_cookie[2];
> +};

[Severity: Medium]

Are cdiag_states, cdiag_ino and cdiag_cookie used anywhere?

As far as I can tell:

- can_diag_handler_dump() only checks req->sdiag_protocol.
- can_diag_dump() walks every socket without filtering.
- sk_diag_fill() only tests the CDIAG_SHOW_UID bit.

Nonzero values in these fields or in pad, and unknown cdiag_show bits, are
all accepted and ignored.

A caller that fills in a states mask, as ss does for unix_diag, gets
unfiltered results. Once this is released, giving these fields a meaning
or requiring them to be zero would change behaviour for existing
binaries. Should unsupported fields and bits be rejected with -EINVAL for
now?

The inode fields also differ in width. The request cdiag_ino is __u32,
while the response cdiag_ino is __u64 and sock_i_ino() returns u64:

include/net/sock.h:
static inline u64 sock_i_ino(const struct sock *sk)

Can the request field hold the full inode number it is meant to match?

The commit message also does not say that state, inode and cookie
filtering are unimplemented.

[ ... ]

> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index abbb4be7ad215..6766efe83630e 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -70,4 +70,13 @@ config CAN_ISOTP
>  	  as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
>  	  traffic.
>  
> +config CAN_DIAG
> +	tristate "CAN socket monitoring interface"
> +	default m
> +	help
> +	  Support for CAN socket monitoring interface used by the ss tool.
> +	  If unsure, say M.
> +
> +	  Enable this module so userspace applications can query open sockets.

[Severity: Low]

Is default m intended here?

Enabling CONFIG_CAN_DIAG does more than build an optional module. Through
IS_ENABLED(CONFIG_CAN_DIAG), it also builds the real can_add_sock_sklist()
and can_remove_sock_sklist() into can.ko, in place of the empty stubs in
include/linux/can/core.h.

With the defaults, every kernel with CAN enabled then takes the per-netns
sklist_lock mutex on each CAN socket create and release, even if can-diag
is never loaded. The diag interface is also exposed by default.

Most similar diag options (UNIX_DIAG, PACKET_DIAG, NETLINK_DIAG,
XDP_SOCKETS_DIAG) default to n. The commit message does not mention this
choice.

This isn't a bug, but "If unsure, say M." is placed in the middle of the
help text, before the last paragraph.

> +
>  endif

[ ... ]

> diff --git a/net/can/diag.c b/net/can/diag.c
> new file mode 100644
> index 0000000000000..11281f75ecd52
> --- /dev/null
> +++ b/net/can/diag.c
> @@ -0,0 +1,204 @@

[ ... ]

> +static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
> +			struct can_diag_req *req, /* will be used for filtering */
> +			struct user_namespace *user_ns,
> +			u32 portid, u32 seq, u32 flags, u64 sk_ino)
> +{

[ ... ]

> +	rep->cdiag_family = AF_CAN;
> +	rep->cdiag_type = sk->sk_type;
> +	rep->cdiag_ino = sk_ino;
> +	rep->cdiag_protocol = sk->sk_protocol;
> +	rep->cdiag_state = READ_ONCE(sk->sk_state);

[Severity: Medium]

Does any CAN protocol ever update sk->sk_state?

I could not find a writer under net/can/. The only assignment seems to be
in sock_init_data_uid(), which can_create() reaches through
sock_init_data():

net/core/sock.c:sock_init_data_uid() {
    ...
	sk->sk_state		=	TCP_CLOSE;
    ...
}

If so, every CAN socket reports TCP_CLOSE, whether it is unbound, bound
or connected (for example J1939_SOCK_BOUND/CONNECTED, or raw ro->bound).
ss would show a misleading TCP-style state for every CAN socket.

cdiag_state, and the cdiag_states filter in the request, become uAPI.
Which CAN state is this field meant to carry? The commit message does not
say.

> +	sock_diag_save_cookie(sk, rep->cdiag_cookie);
> +
> +	if ((req->cdiag_show & CDIAG_SHOW_UID)) {
> +		err = sk_diag_dump_uid(sk, skb, user_ns);
> +		if (err < 0)
> +			goto cancel_nlmsg_err;
> +	}
> +
> +	memset(&can_addr, 0, sizeof(can_addr));
> +
> +	err = kernel_getsockname(sk->sk_socket, (struct sockaddr *)&can_addr);

[Severity: High]

Can sk->sk_socket point to a freed struct socket here?

can_create() adds the new sk to net->can.sklist and then drops the
protocol module reference:

net/can/af_can.c:can_create() {
    ...
	} else {
		can_add_sock_sklist(sk);

		sock_prot_inuse_add(net, sk->sk_prot, 1);
	}

 errout:
	can_put_proto(cp);
    ...
}

Back in __sock_create(), suppose a concurrent rmmod of can-raw,
can-isotp, can-bcm or can-j1939 has already moved the module to
MODULE_STATE_GOING. Then try_module_get() fails:

net/socket.c:__sock_create() {
    ...
	if (!try_module_get(sock->ops->owner))
		goto out_module_busy;
    ...
out_module_busy:
	err = -EAFNOSUPPORT;
out_module_put:
	sock->ops = NULL;
	module_put(pf->owner);
out_sock_release:
	sock_release(sock);
    ...
}

Because sock->ops is cleared, __sock_release() skips the protocol
->release(). can_remove_sock_sklist() never runs, and sock_orphan() is
never called.

The socket inode is freed, but the sk stays on sklist, kept alive by the
reference that sk_add_node() took. Its sk->sk_socket still points at the
freed socket.

A later dump then reaches this sk:

can_diag_dump()
  sk_diag_fill()
    kernel_getsockname(sk->sk_socket, ...)
      READ_ONCE(sock->ops)->getname(...)

This reads freed memory and makes an indirect call through it.
sk->sk_prot also points into the unloaded module.

The list insertion comes from the earlier patch "can: store socket
pointers in struct netns_can". Before this patch the stranded sk was only
leaked. This patch is the first to dereference it, and any unprivileged
user can trigger the dump.

> +	if (err < 0) {
> +		/* Some protocols (e.g. CAN_BCM) do not implement kernel_getsockname().
> +		 * No error returned because the netlink message is still valid.
> +		 */
> +		if (err == -EOPNOTSUPP)
> +			goto exit_no_err;

[Severity: Medium]

The commit message says the response includes "the interface index for
bound sockets". Does that hold for CAN_BCM?

bcm_ops uses .getname = sock_no_getname, which returns -EOPNOTSUPP. This
path then jumps to exit_no_err before rep->cdiag_ifindex is set. A BCM
socket connected to an interface therefore reports ifindex 0, the same
value as an unbound or "any" socket, so userspace cannot tell them apart.

The commit message also does not mention the protocol specific attributes
that become uAPI (CAN_DIAG_ISOTP_TX_ID/RX_ID and
CAN_DIAG_J1939_NAME/PGN/ADDR). The header does not document their types
either.

CAN_DIAG_J1939_NAME carries a 64-bit name_t, written further down with
plain nla_put():

	err = nla_put(skb, CAN_DIAG_J1939_NAME, sizeof(j1939_name), &j1939_name);

There is no pad attribute, so the 8-byte payload may only be 4-byte
aligned. Would nla_put_u64_64bit() with a pad attribute fit better here?

> +
> +		goto cancel_nlmsg_err;
> +	}

[ ... ]

> +static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	int num = 0, s_num = cb->args[0];
> +	struct can_diag_req *req;
> +	struct net *net;
> +	struct sock *sk;
> +
> +	net = sock_net(skb->sk);
> +	req = nlmsg_data(cb->nlh);
> +
> +	lock_can_diag_mutex(net);
> +	sk_for_each(sk, &net->can.sklist) {

[Severity: High]

Can an unprivileged user use this lock to stall every CAN socket create
and close in the netns?

sklist_lock is held for the whole walk, and sk_diag_fill() calls
kernel_getsockname() for each socket. For CAN_J1939 that ends up in
j1939_sk_getname(), which does lock_sock(sk). That wait is
uninterruptible.

A blocking sendmsg can hold a J1939 socket's lock for a long time:

j1939_sk_sendmsg()
  lock_sock(sock->sk)
  j1939_sk_send_loop()
    j1939_sk_alloc_skb()
      sock_alloc_send_skb(sk, ..., msg->msg_flags & MSG_DONTWAIT, &ret)
        sock_wait_for_wmem()

sock_wait_for_wmem() does not drop the socket lock, and the default
sk_sndtimeo is MAX_SCHEDULE_TIMEOUT. A large (E)TP message (up to about
117 MB) with a small SO_SNDBUF keeps sendmsg waiting at CAN bus speed, or
longer if the peer delays CTS.

Meanwhile a SOCK_DIAG dump sleeps in lock_sock() with sklist_lock held.
The dump needs no privilege, and can-diag auto-loads through
MODULE_ALIAS_NET_PF_PROTO_TYPE.

The same mutex is taken by can_create()->can_add_sock_sklist() and by the
raw, isotp, bcm and j1939 release paths through can_remove_sock_sklist().
All of them block too:

net/can/af_can.c:
	lock_can_diag_mutex(net);
	sk_add_node(sk, &net->can.sklist);
	unlock_can_diag_mutex(net);

In that netns no CAN socket can be created or closed. Exiting tasks hang
in fput(), and hung task warnings fire. This can also happen by accident
when ss runs during a large J1939 transfer.

No path seems to take sklist_lock while holding lock_sock, so this is a
long stall rather than an ABBA deadlock. Before this series, sklist_lock
was never held while sleeping on another socket's lock.

> +		if (num < s_num)
> +			goto next;
> +
> +		if (sk_diag_fill(sk, skb, req,
> +				 sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				 NETLINK_CB(cb->skb).portid,
> +				 cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				 sock_i_ino(sk)) < 0)
> +			goto done;
> +next:
> +		num++;
> +	}
> +done:
> +	unlock_can_diag_mutex(net);
> +	cb->args[0] = num;

[Severity: Medium]

Can a multi-part dump resume at the wrong socket?

Only the position is saved in cb->args[0], and sklist_lock is dropped
between rounds. can_add_sock_sklist() inserts at the head with
sk_add_node(), and can_remove_sock_sklist() can remove a node anywhere in
the list.

If a socket is created between rounds, every existing entry moves one
place later, so the last socket of the previous round is sent again. If a
socket below the cursor is closed, the next unreported socket moves into
the cursor's slot and is skipped.

No generation counter is kept in cb->seq and nl_dump_check_consistent() is
never called, so NLM_F_DUMP_INTR is never set. ss would get duplicated or
missing sockets with no sign that the listing is inconsistent.

Should this follow the netlink guidance and set NLM_F_DUMP_INTR when the
list changes during a dump?

> +
> +	return skb->len;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-feat-can-diag-v4-0-c28842c74c95%40redhat.com
