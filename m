Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933364;
	b=l+DL7sByRtYebU/MxlOTQnnpUfQ04ktWjy1MCn3d6wEPPvKUy8843eWK0YobbxQ7VAko
	 2y8TjwlyqhRD+JT9qKN8at6W0echQctiNmnKXhg4mXhmDNTRexKAUoP74cOTEXkWS9QEd
	 dY2P85fZCtpmpH5Qcut3bKjzLCclyKIS9fQo4aY951sRX85YFOjaKSvrDa0Nv8EK2dc+8
	 WzgURvdWCK0Imb/BnwMoWcGDUMJZZs3SWI29+hsEBGOUDBEXvXRhqHZiSndESq65NIYVj
	 v2k0O/ayVdUNzro0clnmZsUsb2fCytl5uk9H+uDl+7MhvBjB7yftu+qUyEWt6ZbRHyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933364;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=++ycLgCZ4rNLzAH8vEibOFxUvfAy4uDDzfMU2fCOxTc=;
	b=tYEyk+Ly1riqvdNt2IIBN1qY7+hUs2RGiqqCX/yXXDKVhF5ad4CEUJlHlJucy9cRt6lM
	 maa1In1Pf/MCTwXOyFytdF3JYGM6HVt+YCFAsR0z33UMK1zxy/DwrlM4lIqo0xyv8BFbs
	 WtNrOWyAayu1nRZpGT1nFK26EWVBHWlNEbt/o7DnwI9fj9hOo8y1KQbK0EyBQBBfeFMcD
	 MgfJ6adYzB3Pzz+4OdjBjIqJyhkw2UIW4Bun0KUFMzk2hkJDlaOk+J3DfJ4RODa66cmMY
	 pQp2xWyOHe1tD+gKSfi03CLE/FHhIkDacHeXuXJt052zk4RcEBQXPkfe6B7SwUZ7TKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=C9GCO1Ne;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bXvzNwiy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.23
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCD606A32C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 16:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80BCD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=C9GCO1Ne;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bXvzNwiy
ARC-Seal: i=1; a=rsa-sha256; t=1794933347; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jhh0c/yrDwDigVNlXZytup1m9zr/6gE1cqKRxkdW/5nZ1MUCJVfHKzQnhMn3AWRcKv
    CEvmolgY9f6BxCxBrnXOMxoRo/bwoHoplwR3LISOCjFGGUt8qMwKCUx9r7ze0uIcmdIC
    F3SPWZAiimxiffR3rahFyh4me3Iu9zrf9j27YQSLTiBDlyDf8PRGk3DPTCZ1J9ZC2YOv
    SDcmHNonnS6hYL83FLrBDcbnptEU96UDOBgyhkSy/98rR1Smu049uWs+ULA8QwnHhPXB
    hu/m+YYL6lY9qIy5/zkHtLRRQdZnPU3EdYoqN2rYTXqZchLtr87eogd7f8qnjJNfabq6
    Ci8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933347;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=++ycLgCZ4rNLzAH8vEibOFxUvfAy4uDDzfMU2fCOxTc=;
    b=W+sfdzLq60JjSgNLlG0+yqZ+RxQngsJWt0rIDHZ9zRmxJsOKU+sQTvLYEhTCcBLN9K
    fVpieLfNGDE7iB1B+VVcyoBTYq3QPrBCgbFUXgj/xpqhZ2x8uaSl8yUQfdEAQrDwYDg6
    t2CFvdlwf6+BRva0vtUm1tlaPVzj7tgTgiqPbHle/7bfBjlo6G0NxZhi61uU/XEUEQpF
    JwreBx4zT9PKUMijYY2H1JyAhFYNowQJVLRgRO1RdLQCEI10ZylvNU/i3qFBEk9+/cCz
    cjhGqKi/+06x14Hjj1808fR4nSLwULR6zYER7qt1qdNa58xvkpeug9acRb6++3Z+MyF9
    ncnA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933347;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=++ycLgCZ4rNLzAH8vEibOFxUvfAy4uDDzfMU2fCOxTc=;
    b=C9GCO1Ne9D42t6LeTS3R25n7zV+hZ77aCUI+RtI9RVo1EDaSRYnrP4g9RZ9gnb1nYv
    ffl1bwp3L9G0jjBMR8/Q9SvMOsQOR8To2lAXjiLg53wF9HIP0MfxwBQQQCrwPFpOT4Ft
    +roDot1JL2esYkznVDzPN+6PZvHgLm3XwRoUMfyqpeZBcdMIfPyRNE7U6P8wy9BcmeRD
    Cl1/Cwl1ApqDAPOn3gDFmXlkhWW2hZkJvjhCWzY84XJfyz/5kRcyeEGf+3+CRns+Fx20
    y7kM6/te8I7ZHFZsdf+Eyw8eiE+rtRPMUP+Mqn96i22Fp/zh1xJEkFM72M9ma8nCvzBt
    VZAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794933347;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=++ycLgCZ4rNLzAH8vEibOFxUvfAy4uDDzfMU2fCOxTc=;
    b=bXvzNwiyY0jcmVWmf6hGllGeG864LXDVepf90ZBQGYUhcrlTmfVnTbMVXbwWs3djuJ
    oz72gBu3H3c4BTJSGACQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHGZlceO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:35:47 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v6 0/8] can: avoid RTNL stalls and fix CAN_ISOTP and
 netlink issues
Date: Tue, 17 Nov 2026 17:35:41 +0100
Message-Id: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PyWrDMBQF0F8JWldF85BV/6NkIUtPsZp6QHJMS
 /C/V043poguL9x3Lu+BCuQEBZ1PD5RhTSVNYw3q5YR878Yr4BRqRowwRSnR2LsRd374nPwNDzD
 4K2bBONBcUcMNqndzhpi+nub75TeXe/cBftmhvdGnskz5+zm60r33n79STLAwLNgoO6AxvPUuL
 7dpnl9HWNA+sbIjYloIqwi10cUQvQ2UNRB+RGwL4RVhQVvjHSdSmwYiDgilLURURApmFNFOERM
 biDwivIXIiiguPAEiOq//vrNt2w/QTEPL2wEAAA==
X-Change-ID: 20261107-can-bcmlock-memcg-2d8ae7361838
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933347; l=5439;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=EOUa1wJVwQQuILUChI8hwvmCpTgOjqbYY9c9DvvhHgk=;
 b=2cHs8lwM6RRyr0QGG/eUpNIdwLQB0/qGyxJym5xi1gZKfWKVmEIzcI3gXwF2FsGm4LxND2Kog
 pf2Y+hrQpKdBu+XXmElLtYlFxAqtmgPGdnD6y16DCHCaNyAUsKWRevC
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Hi Marc,

this series replaces the following patches of your pull request
"pull-request: can 2026-11-15", which has not been merged into net yet:

- the five patches of "can: avoid RTNL stalls in CAN_RAW, CAN_ISOTP and
  CAN_BCM" (v5), which are unchanged in this series (patches 1 to 5)
- "can: netlink: fix static FD-NON-ISO mode validation" by Zhu Ling,
  which is replaced by an updated version (patch 8)

The other netlink patches by Zhu Ling ("fix IFLA_CAN_BITRATE_MAX
attribute sizing" and "fix CAN XL PWM attribute sizing") and your gs_usb
patch are not touched. Both netlink patches apply unchanged on top of
patch 8. Could you please update your pull request accordingly?

Patches 1 and 2 avoid RTNL stalls in CAN_BCM: the CAN frames are copied
outside of lock_sock() and the procfs entry of a socket is only removed
in bcm_release().

Patches 3 to 5 replace lock_sock() with a private mutex in CAN_RAW,
CAN_ISOTP and CAN_BCM, so that the generic SOL_SOCKET options, which
access user space under the socket lock, can not block the netdev
notifiers under RTNL anymore.

Patches 6 and 7 fix pre-existing CAN_ISOTP issues that came up in the
Sashiko review of patch 4. Patch 6 makes sure that the rx timeout is
always running in ISOTP_WAIT_DATA state, so the rx state can not get
stuck after the CAN device has been removed. Patch 7 rejects socket
options while a transfer is still active, like isotp_bind() already
does. Patch 6 is needed before patch 7, as otherwise a stuck rx state
would also block setsockopt().

Patch 8 is Zhu Ling's fix for the static FD-NON-ISO mode validation,
updated after the Sashiko review of the pull request: instead of
restoring the static control modes after the update, a request that
switches off a static control mode is rejected with a dedicated error
message, and the commit message describes the full impact.

The series has been tested on a kernel with PROVE_LOCKING and KASAN with
the CAN locking test suite, including new tests for patches 6 and 7,
which fail without these patches and pass with them.

The memcg accounting patch and the follow-up patches for
raw_getsockopt() and isotp_getsockopt() will be sent for can-next.
CAN_J1939 still takes lock_sock() under RTNL in its netdev notifier and
will be addressed separately.

---
Changes in v6:
- new patches 6 and 7: CAN_ISOTP rx timeout and socket option fixes for
  pre-existing issues found in the Sashiko review of patch 4
- new patch 8: updated version of Zhu Ling's "can: netlink: fix static
  FD-NON-ISO mode validation" from the pull request, after the Sashiko
  review of that patch
- Link to v5: https://patch.msgid.link/20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net

Changes in v5:
- removed patch 6 "can: enable memcg accounting for user triggered
  allocations" from this series, it will be sent for can-next
- patches 3 and 4: the comment for conf_lock names setsockopt, as most
  options are read without the mutex in getsockopt() like before. The
  commit messages point to the follow-up patches (Sashiko review)
- Link to v4: https://patch.msgid.link/20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net

Changes in v4:
- new patches 3 to 5: replace lock_sock() with a private mutex in
  CAN_RAW, CAN_ISOTP and CAN_BCM, so that the generic SOL_SOCKET options
  can not block the netdev notifiers under RTNL anymore
- patch 6 (was patch 3): charge the isotp RX buffer to the memory
  cgroup of the socket with set_active_memcg() (Sashiko review)
- Link to v3: https://patch.msgid.link/20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net

Changes in v3:
- patch 2: read bo->bound and bo->ifindex with READ_ONCE() for NETDEV_DOWN
  and shortened the bcm_notify() comment (Sashiko review)
- Link to v2: https://patch.msgid.link/20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12@hartkopp.net

Changes in v2:
- patch 1: fixed the description of the stack buffer and described the
  remaining generic SOL_SOCKET paths (Sashiko review)
- patch 2: read and write bo->ifindex with READ_ONCE()/WRITE_ONCE() for
  the lockless access in bcm_proc_show() (Sashiko review)
- patch 3: keep the GFP_USER | __GFP_NOWARN flags of memdup_sockptr()
  for the filters and describe the local j1939 ECUs (Sashiko review)
- Link to v1: https://patch.msgid.link/20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net

---
Oliver Hartkopp (7):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: raw: use a private mutex instead of lock_sock()
      can: isotp: use a private mutex instead of lock_sock()
      can: bcm: use a private mutex instead of lock_sock()
      can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
      can: isotp: reject socket options while a transfer is active

Zhu Ling (1):
      can: netlink: fix static FD-NON-ISO mode validation

 drivers/net/can/dev/netlink.c |  10 +++-
 net/can/bcm.c                 | 114 ++++++++++++++++++++++++++++++------------
 net/can/isotp.c               |  50 +++++++++++-------
 net/can/raw.c                 |  41 ++++++++-------
 4 files changed, 145 insertions(+), 70 deletions(-)
---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261107-can-bcmlock-memcg-2d8ae7361838

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

