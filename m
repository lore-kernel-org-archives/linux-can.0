Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793004924;
	b=Vh/Xqv5mLbbP3VwhLIthNE9BXSrwLeN92PUNve9Y5r/eNLDeZQAEVD24luADPB1DIaXa
	 1fAa9BU3oVm/eAuIdHGTeYOLkRcJB+qbKSVu1mzKtRXC4PatJlHduBeg3V+eFCOZ55aHD
	 nroxq6oy/P42XT2lcAFx9j8z7pANZf2elw+3LxjYFmU9QYr1FPpEJJ5L12FsSscnblm99
	 vfieOS4Yeo5xNAbgg8B+rJrqcGSzjcOQ3ib57EZBYPBZZ2iPTfCocvHinUrD9PGXDcKDO
	 a8u3VuNGzkcy8D/4JxSZWCR7MdzbjR0fJUxzNxGe1Eq/bEsb4f45gjcfKPWH1gXP5Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004924;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HAII52h5SomFcl7GJyDuGGbHUc4x2RfSf+Cewfbm9rs=;
	b=X4d3AtaF5J0aiCE/qwbdZ65p3W2Yxp7YJUgXsPiYj2vzKp7X57F43A8c/zmu9MfxpZ1e
	 sv2YpuSkmcdjBKqfLFrjvbgHP1iIgQIWDmNmfVeYcdrmWKlMsy0vZMcgHB4Ud3v7WDmd9
	 0vsrwCz9MsV+G798pjCfdNvx9HzsJvYWZD6sflItsLSxhDGqMRZWiX2RvUU1jtSsPNvL2
	 q7+Pwwv5PfzYG26JXN9ETDto1Av3hNjI4TvgXJk08rVWV496ul8HRrNAkMv4NtVmG1nUE
	 LkyTmgR+IOAKD50Yqcs3ailI89Xgr+J4lf8ZNZ/EUxWqZaCey+Csv70Oxb5Pjjv9jDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=eQtGgGQV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=gU92mGEE;
	arc=fail smtp.remote-ip=81.169.146.169
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8B606A31E
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 08:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0F8B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=eQtGgGQV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=gU92mGEE
ARC-Seal: i=1; a=rsa-sha256; t=1793004921; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PJI10VfYNuG67PNx1aPsCr+/RurBpBCS3HD1FKJrEMusIeUQx3F5tR3z2ldBJo3baJ
    8EIpOiWutRhRHUl9pAPcwOva6Xhgt9hiOqzQiZNHA9NzoNrNuG0c/GaBbJoOqGuFhrH0
    6VmiAiRNyrJTtjZ3G0xdOvt567Nlviw63qrOwEvTdD42vNVRT8UMfK929syUG/hpQbSS
    OXXBZ1HOaOiOAJK19/CXp1ClAyvWV8jc2l6+DGLyhjOULZRaOyJeIWU/w9EMDh2Ayxrw
    vSqcyubrRt5BLfi8v94hae5YttmUJzsHuiLdqMir869Nqn6LJjOlWD8oixHtZS4s4vcc
    WTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793004921;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HAII52h5SomFcl7GJyDuGGbHUc4x2RfSf+Cewfbm9rs=;
    b=HDuOhGXFy/DPjnzdGDQvQ/aYyMsvCfBcY7pe6dIrJwIHbrDOq+qkAmWzhktTaSgcSF
    JE2yCl5tHDgq5trPSlcDrbSi+L4IF9Xo7SEu7kTKlkzD1LDDgXNMljiqPkCXR3adItLt
    v92ULwrE2ghZ4Aag9LRXxhVNeQCeOAFdWQ+Af9rkN1daUo1Hl82XST7nU2MSThsSnaRT
    H+SWJHsfMsw0gUDkSgWjVsQdGU35JeCamKgz46z+JGoPdvt8iyyM9S4jU1Z/EgYF4+x/
    TJCgNhWTD68oM8uu21J9SxB7r5wGyyI3L/Lo1CsldgrWDpat0jiGWNfkDmiRjDPKOqjm
    M9rg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793004921;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HAII52h5SomFcl7GJyDuGGbHUc4x2RfSf+Cewfbm9rs=;
    b=eQtGgGQVlHAY/+XihnriiCLVZnY9ftjiIuAeXBdaufD94/iKthhY94mfNkRR02q9Ss
    DkVPsCJ8M2QG0J9WH/Vyv8OlEFjgmyLpufElDm16jzbZZ3ZNcKmEBrnE/zExKjSL3tVd
    L+6+eRdBcXEfjdqVinVZ1FTOwcB62KMbAyLTzxMdGeHsw3o3RMYak3WvGqlbIM1HVqzu
    QvlpuO8F/cve3WxBtU1IUqLdRXUTanbXNLvJMuazVnjuLWhEQcKAjmuk8qk2GXyNaePf
    toipN8jRxskNwre3N8YA+v3dVsqqrGM+PrA9iJ1MNSBLx6Lb/rdAJ/LPVb/9y+yrdnMu
    v9xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793004921;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HAII52h5SomFcl7GJyDuGGbHUc4x2RfSf+Cewfbm9rs=;
    b=gU92mGEEeuC6Two37pQLxcLtB9Xgze1T/Q1yVkJQgWxz9qAeO2hSFQtHED3Tx0+Jf8
    3ayLmz8K+qtj+ECvioAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29Q8tK0mH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 09:55:20 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 26 Oct 2026 09:54:22 +0100
Subject: [PATCH v10 7/7] can: raw, isotp: copy socket options outside of
 lock_sock()
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-can-rx-lock-v10-7-281c4b556a1a@hartkopp.net>
References: <20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net>
In-Reply-To: <20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793004919; l=15472;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=fPVJPC/4aKvsWu870Q6mmEHmknpk852dPTdgfTliwjc=;
 b=Qf+WWIF7ka340oeP3WEgnue1tt4EITNBePiDCbtGCdjseW1BGB2XlcQqkYbtFPEakOSov+MrW
 pW4TeheEjUGD4pdomtAQe/dnSCt+HFtg4rj0jxJX4pygYvYkXRHJCo7
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The CAN_RAW and CAN_ISOTP specific socket options are copied from and
to user space while holding lock_sock(). A copy that faults or stalls,
e.g. on a userfaultfd or FUSE backed mapping, holds lock_sock() for its
whole duration.

raw_notify() and isotp_notify() take lock_sock() of a socket that is
bound to the vanishing device while holding RTNL. As the CAN_RAW
options can also be changed on a bound socket, a stalled copy can block
RTNL on an unregistration or namespace change of the bound device.
Before "can: protect the receive lists with a per-device lock",
raw_setsockopt() even held RTNL itself during the copy. CAN_ISOTP only
copies its options for unbound sockets, which isotp_notify() skips
without taking lock_sock().

Keep the user space copies out of the locked sections: Check the option
name and length and copy the option values, including the CAN_RAW_FILTER
filters, to kernel memory before lock_sock(). raw_setsockopt_locked()
and isotp_setsockopt_locked() get the copied values directly and drop
their now redundant length checks and copies. As a side effect, a
failing copy can not leave partially overwritten options behind
anymore. In raw_getsockopt() duplicate the filters under lock_sock() and
copy them to user space after release_sock().

As the option name and length are now checked before lock_sock(), the
order of the checks in isotp_setsockopt() and accordingly the order of
the returned error values changes. This is in line with POSIX, which
does not define an order in which multiple error conditions are
detected and reported.

The generic SOL_SOCKET options in sk_setsockopt() are not affected by
this patch.

Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
Cc: stable@vger.kernel.org # depends on "can: protect the receive lists with a per-device lock"
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 100 +++++++++++++++++-------------
 net/can/raw.c   | 186 +++++++++++++++++++++++++++++---------------------------
 2 files changed, 155 insertions(+), 131 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 19a9c041b319..d107ae50e6f1 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1699,27 +1699,23 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	addr->can_addr.tp.tx_id = so->txid;
 
 	return ISOTP_MIN_NAMELEN;
 }
 
-static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
-			    sockptr_t optval, unsigned int optlen)
+static int isotp_setsockopt_locked(struct socket *sock, int optname,
+				   const void *val)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	int ret = 0;
 
 	if (so->bound)
 		return -EISCONN;
 
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
-		if (optlen != sizeof(struct can_isotp_options))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&so->opt, optval, optlen))
-			return -EFAULT;
+		memcpy(&so->opt, val, sizeof(so->opt));
 
 		/* no separate rx_ext_address is given => use ext_address */
 		if (!(so->opt.flags & CAN_ISOTP_RX_EXT_ADDR))
 			so->opt.rx_ext_address = so->opt.ext_address;
 
@@ -1740,59 +1736,41 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 				so->frame_txtime = so->opt.frame_txtime;
 		}
 		break;
 
 	case CAN_ISOTP_RECV_FC:
-		if (optlen != sizeof(struct can_isotp_fc_options))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&so->rxfc, optval, optlen))
-			return -EFAULT;
+		memcpy(&so->rxfc, val, sizeof(so->rxfc));
 		break;
 
 	case CAN_ISOTP_TX_STMIN:
-		if (optlen != sizeof(u32))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&so->force_tx_stmin, optval, optlen))
-			return -EFAULT;
+		so->force_tx_stmin = *(const u32 *)val;
 		break;
 
 	case CAN_ISOTP_RX_STMIN:
-		if (optlen != sizeof(u32))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&so->force_rx_stmin, optval, optlen))
-			return -EFAULT;
+		so->force_rx_stmin = *(const u32 *)val;
 		break;
 
-	case CAN_ISOTP_LL_OPTS:
-		if (optlen == sizeof(struct can_isotp_ll_options)) {
-			struct can_isotp_ll_options ll;
-
-			if (copy_from_sockptr(&ll, optval, optlen))
-				return -EFAULT;
+	case CAN_ISOTP_LL_OPTS: {
+		const struct can_isotp_ll_options *ll = val;
 
-			/* check for correct ISO 11898-1 DLC data length */
-			if (ll.tx_dl != padlen(ll.tx_dl))
-				return -EINVAL;
+		/* check for correct ISO 11898-1 DLC data length */
+		if (ll->tx_dl != padlen(ll->tx_dl))
+			return -EINVAL;
 
-			if (ll.mtu != CAN_MTU && ll.mtu != CANFD_MTU)
-				return -EINVAL;
+		if (ll->mtu != CAN_MTU && ll->mtu != CANFD_MTU)
+			return -EINVAL;
 
-			if (ll.mtu == CAN_MTU &&
-			    (ll.tx_dl > CAN_MAX_DLEN || ll.tx_flags != 0))
-				return -EINVAL;
+		if (ll->mtu == CAN_MTU &&
+		    (ll->tx_dl > CAN_MAX_DLEN || ll->tx_flags != 0))
+			return -EINVAL;
 
-			memcpy(&so->ll, &ll, sizeof(ll));
+		memcpy(&so->ll, ll, sizeof(*ll));
 
-			/* set ll_dl for tx path to similar place as for rx */
-			so->tx.ll_dl = ll.tx_dl;
-		} else {
-			return -EINVAL;
-		}
+		/* set ll_dl for tx path to similar place as for rx */
+		so->tx.ll_dl = ll->tx_dl;
 		break;
+	}
 
 	default:
 		ret = -ENOPROTOOPT;
 	}
 
@@ -1802,17 +1780,53 @@ static int isotp_setsockopt_locked(struct socket *sock, int level, int optname,
 static int isotp_setsockopt(struct socket *sock, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 
 {
 	struct sock *sk = sock->sk;
+	union {
+		struct can_isotp_options opt;
+		struct can_isotp_fc_options rxfc;
+		struct can_isotp_ll_options ll;
+		u32 stmin;
+	} val;
+	unsigned int size;
 	int ret;
 
 	if (level != SOL_CAN_ISOTP)
 		return -EINVAL;
 
+	/* copy the option values from user space before lock_sock() */
+	switch (optname) {
+	case CAN_ISOTP_OPTS:
+		size = sizeof(val.opt);
+		break;
+
+	case CAN_ISOTP_RECV_FC:
+		size = sizeof(val.rxfc);
+		break;
+
+	case CAN_ISOTP_TX_STMIN:
+	case CAN_ISOTP_RX_STMIN:
+		size = sizeof(val.stmin);
+		break;
+
+	case CAN_ISOTP_LL_OPTS:
+		size = sizeof(val.ll);
+		break;
+
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	if (optlen != size)
+		return -EINVAL;
+
+	if (copy_from_sockptr(&val, optval, size))
+		return -EFAULT;
+
 	lock_sock(sk);
-	ret = isotp_setsockopt_locked(sock, level, optname, optval, optlen);
+	ret = isotp_setsockopt_locked(sock, optname, &val);
 	release_sock(sk);
 	return ret;
 }
 
 static int isotp_getsockopt(struct socket *sock, int level, int optname,
diff --git a/net/can/raw.c b/net/can/raw.c
index 0267b4300c24..66e41bf9db3e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -601,67 +601,40 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 
 	return RAW_MIN_NAMELEN;
 }
 
 static int raw_setsockopt_locked(struct socket *sock, int optname,
-				 sockptr_t optval, unsigned int optlen)
+				 const void *val, struct can_filter *filter,
+				 int count)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
-	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
-	struct can_filter sfilter;         /* single filter */
 	struct net_device *dev = NULL;
-	can_err_mask_t err_mask = 0;
-	int count = 0;
+	can_err_mask_t err_mask;
 	int flag;
 	int err = 0;
 
 	switch (optname) {
 	case CAN_RAW_FILTER:
-		if (optlen % sizeof(struct can_filter) != 0)
-			return -EINVAL;
-
-		if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
-			return -EINVAL;
-
-		count = optlen / sizeof(struct can_filter);
-
-		if (count > 1) {
-			/* filter does not fit into dfilter => alloc space */
-			filter = memdup_sockptr(optval, optlen);
-			if (IS_ERR(filter))
-				return PTR_ERR(filter);
-		} else if (count == 1) {
-			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
-				return -EFAULT;
-		}
-
-		/* The reg_state check is only a shortcut: On a concurrent
+		/* @filter has been copied by raw_setsockopt(). It is linked
+		 * to the socket on success and freed by the caller on error.
+		 *
+		 * The reg_state check is only a shortcut: On a concurrent
 		 * unregistration or namespace change raw_notify() waits for
 		 * lock_sock() and removes the filters set here.
 		 */
 		dev = ro->dev;
 		if (ro->bound && dev &&
-		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED) {
-			if (count > 1)
-				kfree(filter);
+		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
 			return -ENODEV;
-		}
 
 		if (ro->bound) {
 			/* (try to) register the new filters */
-			if (count == 1)
-				err = raw_enable_filters(sock_net(sk), dev, sk,
-							 &sfilter, 1);
-			else
-				err = raw_enable_filters(sock_net(sk), dev, sk,
-							 filter, count);
-			if (err) {
-				if (count > 1)
-					kfree(filter);
+			err = raw_enable_filters(sock_net(sk), dev, sk, filter,
+						 count);
+			if (err)
 				return err;
-			}
 
 			/* remove old filter registrations */
 			raw_disable_filters(sock_net(sk), dev, sk, ro->filter,
 					    ro->count);
 		}
@@ -671,25 +644,19 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 			kfree(ro->filter);
 
 		/* link new filters to the socket */
 		if (count == 1) {
 			/* copy filter data for single filter */
-			ro->dfilter = sfilter;
+			ro->dfilter = *filter;
 			filter = &ro->dfilter;
 		}
 		ro->filter = filter;
 		ro->count  = count;
 		break;
 
 	case CAN_RAW_ERR_FILTER:
-		if (optlen != sizeof(err_mask))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&err_mask, optval, optlen))
-			return -EFAULT;
-
-		err_mask &= CAN_ERR_MASK;
+		err_mask = *(const can_err_mask_t *)val & CAN_ERR_MASK;
 
 		/* lockless shortcut, see CAN_RAW_FILTER */
 		dev = ro->dev;
 		if (ro->bound && dev &&
 		    READ_ONCE(dev->reg_state) != NETREG_REGISTERED)
@@ -712,78 +679,46 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 		/* link new err_mask to the socket */
 		ro->err_mask = err_mask;
 		break;
 
 	case CAN_RAW_LOOPBACK:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
-
-		ro->loopback = !!flag;
+		ro->loopback = !!*(const int *)val;
 		break;
 
 	case CAN_RAW_RECV_OWN_MSGS:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
-
-		ro->recv_own_msgs = !!flag;
+		ro->recv_own_msgs = !!*(const int *)val;
 		break;
 
 	case CAN_RAW_FD_FRAMES:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
+		flag = *(const int *)val;
 
 		/* Enabling CAN XL includes CAN FD */
 		if (ro->xl_frames && !flag)
 			return -EINVAL;
 
 		ro->fd_frames = !!flag;
 		break;
 
 	case CAN_RAW_XL_FRAMES:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
-
-		ro->xl_frames = !!flag;
+		ro->xl_frames = !!*(const int *)val;
 
 		/* Enabling CAN XL includes CAN FD */
 		if (ro->xl_frames)
 			ro->fd_frames = ro->xl_frames;
 		break;
 
 	case CAN_RAW_XL_VCID_OPTS:
-		if (optlen != sizeof(ro->raw_vcid_opts))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&ro->raw_vcid_opts, optval, optlen))
-			return -EFAULT;
+		memcpy(&ro->raw_vcid_opts, val, sizeof(ro->raw_vcid_opts));
 
 		/* prepare 32 bit values for handling in hot path */
 		ro->tx_vcid_shifted = ro->raw_vcid_opts.tx_vcid << CANXL_VCID_OFFSET;
 		ro->rx_vcid_shifted = ro->raw_vcid_opts.rx_vcid << CANXL_VCID_OFFSET;
 		ro->rx_vcid_mask_shifted = ro->raw_vcid_opts.rx_vcid_mask << CANXL_VCID_OFFSET;
 		break;
 
 	case CAN_RAW_JOIN_FILTERS:
-		if (optlen != sizeof(flag))
-			return -EINVAL;
-
-		if (copy_from_sockptr(&flag, optval, optlen))
-			return -EFAULT;
-
-		ro->join_filters = !!flag;
+		ro->join_filters = !!*(const int *)val;
 		break;
 
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -792,21 +727,88 @@ static int raw_setsockopt_locked(struct socket *sock, int optname,
 
 static int raw_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
+	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
+	struct can_filter sfilter;         /* single filter */
+	union {
+		can_err_mask_t err_mask;
+		int flag;
+		struct can_raw_vcid_options vcid_opts;
+	} val;
+	unsigned int size = 0;
+	int count = 0;
 	int err;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
 
+	/* Copy the option values from user space before lock_sock(), so a
+	 * stalled copy can not block raw_notify() waiting for lock_sock()
+	 * under RTNL.
+	 */
+	switch (optname) {
+	case CAN_RAW_FILTER:
+		if (optlen % sizeof(struct can_filter) != 0)
+			return -EINVAL;
+
+		if (optlen > CAN_RAW_FILTER_MAX * sizeof(struct can_filter))
+			return -EINVAL;
+
+		count = optlen / sizeof(struct can_filter);
+
+		if (count > 1) {
+			/* filter does not fit into dfilter => alloc space */
+			filter = memdup_sockptr(optval, optlen);
+			if (IS_ERR(filter))
+				return PTR_ERR(filter);
+		} else if (count == 1) {
+			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
+				return -EFAULT;
+			filter = &sfilter;
+		}
+		break;
+
+	case CAN_RAW_ERR_FILTER:
+		size = sizeof(val.err_mask);
+		break;
+
+	case CAN_RAW_XL_VCID_OPTS:
+		size = sizeof(val.vcid_opts);
+		break;
+
+	case CAN_RAW_LOOPBACK:
+	case CAN_RAW_RECV_OWN_MSGS:
+	case CAN_RAW_FD_FRAMES:
+	case CAN_RAW_XL_FRAMES:
+	case CAN_RAW_JOIN_FILTERS:
+		size = sizeof(val.flag);
+		break;
+
+	default:
+		return -ENOPROTOOPT;
+	}
+
+	if (size) {
+		if (optlen != size)
+			return -EINVAL;
+
+		if (copy_from_sockptr(&val, optval, size))
+			return -EFAULT;
+	}
+
 	lock_sock(sk);
 
-	err = raw_setsockopt_locked(sock, optname, optval, optlen);
+	err = raw_setsockopt_locked(sock, optname, &val, filter, count);
 
 	release_sock(sk);
 
+	/* on error free the filters allocated for CAN_RAW_FILTER above */
+	if (err && count > 1)
+		kfree(filter);
+
 	return err;
 }
 
 static int raw_getsockopt(struct socket *sock, int level, int optname,
 			  sockopt_t *opt)
@@ -823,10 +825,11 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 	if (len < 0)
 		return -EINVAL;
 
 	switch (optname) {
 	case CAN_RAW_FILTER: {
+		struct can_filter *filter = NULL;
 		int err = 0;
 
 		lock_sock(sk);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
@@ -837,19 +840,26 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 				err = -ERANGE;
 				opt->optlen = fsize;
 			} else {
 				if (len > fsize)
 					len = fsize;
-				if (copy_to_iter(ro->filter, len,
-						 &opt->iter_out) != len)
-					err = -EFAULT;
+				/* copy to user space after release_sock() */
+				filter = kmemdup(ro->filter, len, GFP_KERNEL);
+				if (!filter)
+					err = -ENOMEM;
 			}
 		} else {
 			len = 0;
 		}
 		release_sock(sk);
 
+		if (filter) {
+			if (copy_to_iter(filter, len, &opt->iter_out) != len)
+				err = -EFAULT;
+			kfree(filter);
+		}
+
 		if (!err)
 			opt->optlen = len;
 		return err;
 	}
 	case CAN_RAW_ERR_FILTER:

-- 
2.53.0

