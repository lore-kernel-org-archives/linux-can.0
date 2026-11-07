Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057334;
	b=YxGw8Y55uxckVxtd2H+Cfk4cIquE7jYc6//aetELAMreCDki/Zne1DufDvu11Q9Qhsxx
	 tGc/wfRUEku+lTjpIx++AciJDicMsNPW2OgzlVDRr1dcw1ZCoIOsoOBMVru7p+9b3Xj5I
	 funUatv8zgJ6jGqmndpsRDfKKH+tOBy1gDSy5ZVj5GFzdb9nTKigY6e3EH/h29dnER9v/
	 sVs3yTHzXZA8jHPsqjj3448mtJjAXQ14blXFlv5xPTpWYALTRg036cdgEAxg071zIfUV0
	 MwFLqtyuBMg/0n3tAXiV4ovO6D0CJ3n4rA1yShPayO56ApypO7HCMpCeZjm67q4shiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057334;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dksHcD0oASjQaqAN4zzMutrZOi4L8bHf0LB8iiT/d/s=;
	b=CR/6nMxNT3jWuHK/HRIgAskKuhS/AoXv+UCmT20UnZbXnzTlD9tCR2QPr3ku28RmGu3f
	 kGxW3gph+E5sluvnwK71wh4pNWlBpef7dvKfIWUYndISSS4WUuXhPIbkczpmZSEivCPwQ
	 2mykOrS8DbMjs7QZMzFyTvnvZ1ACh0hCtprUjbth2dEBFyXQ3dLoGqVmE0gCctVjZeW/c
	 nmfW6La+uvm23XHWq4amSfHTdAjD/V66BTJZwXNr4AUB2vnxvXEx82R1G2aT9U9xlne29
	 nf83tlShh7X29/4Cd81R3U2nHM0rwV3gClzg/1aDYD4aJk519qfgEdYQvjs03z7WYyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IStdDTXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF94606D815
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IStdDTXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316E51F008A1;
	Sat,  7 Nov 2026 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794057333;
	bh=dksHcD0oASjQaqAN4zzMutrZOi4L8bHf0LB8iiT/d/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IStdDTXd5mgNgZrPCltsKhEWD3JA8wat5c2038gVpKr5YsOHWlWIlOfup4XdNkrmx
	 umAjO/X2jL+lm3DpFHZsLUQWFjQB8U/khhHOYcQy8r1TlYaTcXCt95g3q4Z0i5/jL0
	 x52rwy1wizQRC403hG18lNC8OoPKg5Gy26C1VZQekUtgde2A6p5Xi7iq4bsDFV4PZL
	 M1Qww68gZmU6UM6mUon1+UR6x7yqXw/1UrpC9h7AaFXxXy+CBBb2ociFv0yKx+htiN
	 RYkuoMxlDPc0A1YC6N0kvhqvfcSIiASME253MZI5I0F3B9LwB0hSS47S6AfwwdqH3w
	 +yx+tPWL+bCTg==
Message-ID: <sashiko-outbox-202903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] can: bcm: copy the CAN frames outside of
 lock_sock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261107-can-bcmlock-memcg-v1-1-482d9f5be1fd@hartkopp.net>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
 <20261107-can-bcmlock-memcg-v1-1-482d9f5be1fd@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:15:32 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] can: bcm: indefinite rtnl_lock stall in bcm_notify() [1]
--

commit 21cad73125ec2cd172e1d3266d5282c5a3ca76be
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: copy the CAN frames outside of lock_sock()

This commit copies CAN frames from user space into a kernel buffer before
acquiring lock_sock() in bcm_sendmsg(), preventing a stalled user-space copy
from blocking bcm_notify() under RTNL.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 7bd2aa39777af..9c39f7363ca59 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1663,6 +1668,47 @@ static int bcm_sendmsg(struct socket *sock, struct=
 msghdr *msg, size_t size)
>  	if ((size - MHSIZ) % cfsiz)
>  		return -EINVAL;
> =20
> +	/* Copy the CAN frames from user space before lock_sock(), so a
> +	 * stalled copy can not block bcm_notify() waiting for lock_sock()
> +	 * under RTNL. Only the frames the opcode handler reads are copied.
> +	 * The handlers keep their checks and read the frames from fmsg.
> +	 */

[Severity: High]
This problem wasn't introduced by this patch, but can bcm_notify() still
block RTNL indefinitely in remove_proc_entry() [1]?

When a bound CAN device is unregistered, bcm_notify() is called under
rtnl_lock and tears down the socket's /proc/net/can-bcm/<inode> entry:

net/can/bcm.c:bcm_notify() {
	...
	case NETDEV_UNREGISTER:
		lock_sock(sk);
		...
		if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {
#if IS_ENABLED(CONFIG_PROC_FS)
			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
				bo->bcm_proc_read =3D NULL;
			}
#endif
	...
}

Because that procfs entry is world-readable and remove_proc_entry() waits
for active readers (pde_users) to finish, a local user who stalls a read()
on /proc/net/can-bcm/<inode> (for example via userfaultfd or FUSE) causes
remove_proc_entry() to block forever while holding rtnl_lock and lock_sock(=
).

[1] https://sashiko.dev/#/bug/linux-23a32da5-4d8e-457b-9e84-376ce500a113

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-can-bcmloc=
k-memcg-v1-0-482d9f5be1fd@hartkopp.net?part=3D1
