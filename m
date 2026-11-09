Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232163;
	b=1fp0pMnZd4RAyJPJmVIV0CqsR7RWuY+LipziHkYVn4an4pbmOL4BoNw0Vifkl4GA9DtY
	 B6fA3Xa6ZN40ecak9M5lPdS845H9cn8E7mk38++R2Oaxm3pGbUeKxyNI+zntQTEYuW/0k
	 cHKW9RhDANXOoExAIofQJBDWin7fRbrJEDq1tSMESr2wwWgvIlvaxrTu83WAWdtF2vTsp
	 /4onlwLzmjjvUD/PpPA5PVxAOJaKwxMhQmult6j47i9tCVa2rKepvvkbxijsg2r/wo4PD
	 gAklPUeED0TeLLVGVastvdvaMTadvxnwmD4gyx+5IF23suxtdargw+3ixPKS1IEiHKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232163;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=8OfYwom2dzbzgSiyUihcV8RZtvhr5JY69wU+XuXle7Y=;
	b=mwDneKE+pde02wCesnmejXvSO5Q9/1MgBnnYaTu4GR3Gd/4gu2tlXmrj/onZOOpbBiBz
	 M6fulZSKWTHcyvoP4ZSazJOS5OSewv7hggdj472jPVQAVDrW0R30b/SzkVd3QEUJrpFJM
	 9GTdl+S9G4oQM7q9daqfTPH+/cds36JZIvOqaHSd/hWWy+UXLm3stBUKm1Lf0Bb/ueCk2
	 dqALG74q9P9tSiA7lvXLmEN+BrjKEWAIeNn54yF6G7tgo1Iwoz5va8/ykcHFb5F33WJ52
	 huNIQWq/gEQVSo1+nL4esel5zfcE1krEiX8sYG4Af6vO1tH83jaw8N6krOEHE4KqzLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=F7JF27Sc;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965D606A325;
	Mon,  9 Nov 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9965D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=F7JF27Sc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8OfYwom2dzbzgSiyUihcV8RZtvhr5JY69wU+XuXle7Y=; b=F7JF27ScqwrxDCxjQ3APA/FRL2
	Gjf/6s9699Ol/na6dpL7VEULrcO0SjUdZ701hDGvds2KpP9AfjjBsDV3kW8ZiilpowaFij5y7Zygf
	+7F/Tn+zuvNueuzLb5tY5+c90GnMj0Y02mYziUFogbhO/LC0S25BzieBjDKINfWkIp51SxnjaEyTb
	ThYUDtKy/3Tu8xI2phlE46IHN9q/vrORCiwbWidEtBP2tI2WVclY+nOgr9UFfdNP7eGbJsnuamlnq
	KFB0Hhvb3Efj66DEymlxPRtEiF4ajfbL4r0rRquu+pK6BE7/FmVi8YDoxlTemcspY1M0B9QMzt0DY
	S2BgGzXg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQPkL-00BfMa-1i;
	Mon, 09 Nov 2026 13:49:18 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH RESEND v2 0/2] net: convert remaining CAN protocols to
 getsockopt_iter
Date: Mon, 09 Nov 2026 05:46:26 -0800
Message-Id: <20261109-getsock_two_can-v2-0-763f87fb49b2@debian.org>
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
X-B4-Tracking: v=1; b=H4sIALfO8WoC/3WNsQ6CMBQAf6V5MzWlCAqTg6wOOhpCSvso1aQ1b
 UUN4d8NOLteLncTBPQGA1RkAo+jCcZZqAhPCMhBWI3UKKgIcMYLlrMd1RiDk/c2vlwrhaW5ygq
 27dJyz3tICDw89ua9Fq9wri/16QjNj4dnd0MZl9xiDiZE5z/rekxX/+9lTCmjmeQCS1S9UPKgs
 DPCbpzX0Mzz/AW6b2v7yQAAAA==
X-Change-ID: 20260507-getsock_two_can-5d3604b1982f
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=leitao@debian.org;
 h=from:subject:message-id; bh=1/ZPmEhwEqLU9l7GQN4mn2+H2lMx4l6DKvUyFzKezAE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8c9ZpWlTKaKNX8i27/qVGnTbLKYBoT53QTNtr
 cKcCnK0wG2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavHPWQAKCRA1o5Of/Hh3
 bUzID/9DmmMtomd0YGyfhImmSuZ7XoRN15TCjQZs1wA6LL6Ue7ALc1auI3qY1Pdh7brXmePNY/G
 U+GqQPVl0jijQaT79+W+W6Q8cPVpHKPSsnVcePCPpvorKABGC+bcv4aloTxpfBorrgH+uN8OUDb
 d5A+grZGjWIY7hxRPoVwhb0d40ofDdL2DKv0whsl5GacWhKEnlOLOlpaUYbzILZ++mqQ9X+qeQn
 ey4k/Tk3EtXjjJCgF/CcUCQUeXVcQ9TqYgOi/HqrsQkzgFu8yz52+YsxzAfmq76CfbX/BC0oCuC
 O+bP6pcvfM26q1vdCtGqivpbfDIY+q8nGmvPwWH05sjGlXnwF2EAJLGximO84qOfi0T5K8gjJcS
 5P+QQ82l3+UQAKrgRkUWE+Lh9mkbPNK8y11xWuv8LS5aeU+yplhoMd6bfRz/xMBIb4gA83U3++0
 1MtGLP2cIm90ypNs8UiScII2qWY5UyPoNwpSZkVvWKWlUAbdWVzLZX30LWYGz9zIOmDLT/AhiNh
 cRRi31pnAOHbbkh6BHS4rj8/3L3m4ZPRzLqcuUaTqj56x1PiQ2nKaeABnDP+RKOFVNUnbrkJ2de
 CTtUdw0f2yMGuK9v2yveKxoOZAMpX+Kfzbm7ozy4T2A1GYA+GTL8sceNokZxcGIi1OcHupZygCY
 Jp6BbKJl4eGSqOA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Continue the conversion of socket protocols to the new getsockopt_iter
API by covering the two remaining CAN implementations:

  - isotp (CAN ISO-TP)
  - j1939 (SAE J1939)

With these, all CAN protocols that expose a getsockopt callback (raw,
isotp, j1939) now use .getsockopt_iter; raw was converted as part of
an earlier series.

These are mechanical, ABI-preserving conversions following the same
pattern as previously converted protocols (af_packet, can/raw,
af_netlink, af_vsock):

  - The (char __user *optval, int __user *optlen) pair is replaced with
    a single sockopt_t *opt that carries the buffer length on input and
    the returned size on output, and exposes an iov_iter for the
    copy-out path.
  - put_user()/copy_to_user() pairs are replaced with a single
    copy_to_iter() per option.
  - The wrapper in do_sock_getsockopt() handles writing optlen back to
    userspace.

No functional or ABI change is intended.

For more context about the motivation for this change, please check
commit 67fab22a7ad ("net: add getsockopt_iter callback to proto_ops")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Rebase on net-next, no code change
- Collect Acked-by from Oleksij Rempel and Oliver Hartkopp
- Link to v1: https://patch.msgid.link/20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org

---
Breno Leitao (2):
      can: j1939: convert to getsockopt_iter
      can: isotp: convert to getsockopt_iter

 net/can/isotp.c        | 12 +++++-------
 net/can/j1939/socket.c | 21 +++++++++++++--------
 2 files changed, 18 insertions(+), 15 deletions(-)
---
base-commit: fa5196392691051963726787944db872420dfa75
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20260507-getsock_two_can-5d3604b1982f

Best regards,
--  
Breno Leitao <leitao@debian.org>

