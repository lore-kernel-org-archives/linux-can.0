Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795313049;
	b=KYf8Ie5O9JQdTxYv79vkSs2D1bh+MD/RChqfm7ngSGHY1QxrGoMOvt5ZPFcZw3BZmOP7
	 bfJrjWKZs1aFPSVZ37GQPxOhBDn095wfv2pKomF3A3V+5I70c96XmA7AtiymZJbQTVp7+
	 2NkeaF/51/ifvwiDQSX9ZZ9N8787Tc87sBLpGBt4aMNDbqky2PoOVPzM65RebrlBBJ7Az
	 UfOv8OfHf+rnPe+h1LEe9uR5kqBYofxkNPfCv3H0DBZ3K8X8b+3VORI2HBndVDzH0aVHI
	 +jWqjs3YgfOVNOQzBqb37BR2HGiKBHwy99Q59uCgAcPXF3x7X7/8mOzJl60GSaTdZoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795313049;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZaN7fca6cH9OhbXHXdLScj2C9zqD16yeLDqeq22GBJg=;
	b=yTXvJYz46/JwBrQvrCjAz+PZF0kdt/CDQ0W0qqv5+25GNH7psoMCc1Jc3Ad4w+GFhXSk
	 WyC5a1BVUVcxQC694H57ygwyAdWbHi5NojCveiIINbU9EQiLgyjeaprT/HZMdl1XGZr9k
	 kMYuxjTMYa5km/cn3ActsjnxeP1O48+ryIAun5L3ZVzdodu/+oUOWIeqUyoDkXqsHQRxz
	 yvTZsLAg2gaVTRB5ExU1abVO0o2TCEPLPpIsEPpBAR2M2SocVGRCG0XvyR4fnjgXGC8YD
	 cnKb1UqzxfJH/VjjqirvaLcZ4QIRCZLEiNc/mM4wGIKdCyU2x+/vKU0LQoNihKsEUuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOlIRKHn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB5606A320
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOlIRKHn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BC61F000C6;
	Sun, 22 Nov 2026 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795313048;
	bh=ZaN7fca6cH9OhbXHXdLScj2C9zqD16yeLDqeq22GBJg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DOlIRKHnwqvkZwypuOMh7SveeqHfv0hctA1HAgJGBIsNECjFG4rKSYTcDfJzk6dXN
	 azFsPODpRPNHmgRhyCepZIqT6wKzyNqNsRsVuJr6hSkgaNQJem6Sb1ycuPy22Lhw3C
	 JgjpuyJyLmwI8vqFKc05CUfKXr/Lm+vCjD6WC7FSN5153Jycs1Ptj1i0YfrgatAH7Q
	 IUzvYufsNfdk2oYSg1aQKtWpjOEH7fhGO39liEbgeCzv4k3mjC1OJrYJPmqy+BFf1H
	 PyiCA4PdIB9CIjFRS2nsTg59bVBDBGCZpsN26V+mggYmkwec0veBUIPzuoEOkuDFtU
	 dvW91jBrcv7ew==
Subject:
 Re: [PATCH v7 5/8] can: bcm: use a private mutex instead of lock_sock()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
Date: Sun, 22 Nov 2026 02:04:08 +0000
Message-ID: <179531304802.3131.12745921065969332467@kernel.org>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-5-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-5-f6b84f5257b1@hartkopp.net>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The stable dependency note "Cc: stable@vger.kernel.org # depends
  on \"can: bcm: copy the CAN frames outside of lock_sock()\"" is…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but CAN_J1939 has
  the same RTNL-stall pattern that this series removes from CAN_RAW,…

--

can: bcm: use a private mutex instead of lock_sock()

This patch replaces lock_sock() in CAN_BCM with a private conf_lock mutex
in struct bcm_sock. The generic SOL_SOCKET options access user space under
the socket lock, and with this change they can no longer stall bcm_notify()
while it holds RTNL. bcm_release() now removes the procfs entry before it
takes the new mutex.

> Cc: stable@vger.kernel.org # depends on "can: bcm: copy the CAN frames outside of lock_sock()"

[Severity: Low]
Is this dependency note complete? The patch also seems to depend on "can:
bcm: do not remove the procfs entry in bcm_notify()", which comes earlier
in the same series.

That commit turned the plain bo->ifindex = 0 assignments into WRITE_ONCE().
This patch uses the new lines as context, for example in bcm_release():

		WRITE_ONCE(bo->ifindex, 0);
	}

+	mutex_unlock(&bo->conf_lock);

If only the listed prerequisite is applied, this patch will not apply
cleanly.

The dependency is also functional. The commit message says bcm_release()
removes the procfs entry before taking the mutex. That assumes the entry
is only ever removed in release.

Without the prerequisite, bcm_notify() still calls remove_proc_entry()
inside the NETDEV_UNREGISTER section. With this patch, that call would run
under conf_lock with RTNL held. If a backport is resolved by hand, the
RTNL stall would remain through a procfs reader stuck in copy_to_user().

The prerequisite has its own Cc: stable tag and comes first in the series,
so applying the series in order works. Could the "# depends on" note list
it too?

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 1595b7720c981..dc9e2890490ac 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1843,7 +1844,7 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
>  	switch (msg) {
>  
>  	case NETDEV_UNREGISTER:
> -		lock_sock(sk);
> +		mutex_lock(&bo->conf_lock);
>  
>  		/* rx_ops: remove device specific receive entries */
>  		list_for_each_entry(op, &bo->rx_ops, list) {

[Severity: High]
This isn't a bug introduced by this patch, but CAN_J1939 seems to have the
same RTNL stall that this series removes from CAN_RAW, CAN_ISOTP and
CAN_BCM.

On NETDEV_UNREGISTER, the j1939 notifier runs with RTNL held and takes the
socket lock of every bound socket:

j1939_netdev_notify()
  j1939_sk_netdev_event_unregister()

net/can/j1939/socket.c:j1939_sk_netdev_event_unregister() {
    ...
		lock_sock(sk);
		if (jsk->state & J1939_SOCK_BOUND) {
    ...
}

So if a task holds the socket lock of a bound j1939 socket while it
accesses user memory, it can block RTNL. There appear to be two such
paths.

The first is the generic SOL_SOCKET options. For example, SO_ATTACH_FILTER
in sk_setsockopt() copies the filter from user space under
sockopt_lock_sock():

net/core/sock.c:sk_setsockopt() {
    ...
		ret = copy_bpf_fprog_from_user(&fprog, optval, optlen);
		if (!ret)
			ret = sk_attach_filter(&fprog, sk);
    ...
}

The second is j1939_sk_sendmsg(). It holds lock_sock() across
j1939_sk_send_loop(), which copies the payload from user space:

net/can/j1939/socket.c:j1939_sk_sendmsg() {
	lock_sock(sock->sk);
    ...
	ret = j1939_sk_send_loop(priv, sk, msg, size);

sendmsg_done:
	release_sock(sock->sk);
}

If the user buffer is on a FUSE backed mapping, either copy can stall for
as long as the user wants.

can_create() has no capability check. A user can create a vcan device in
their own user and network namespace, bind a j1939 socket to it, stall one
of these copies, and then delete the vcan device. RTNL would then be held
until the copy finishes.

None of the commit messages in the series mention j1939. Should CAN_J1939
get the same conversion, or should the series say that it is still
affected?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1%40hartkopp.net
