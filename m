Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568515;
	b=E+c1jmtUUwr7TlBifamnIG9kj7tsHeTlAS3UjV0RiRISyMrBuX1AarRAflKGjTRpoP+y
	 MB4KV46ICk2MO4+wZvPMNcorx3xdsjc7+BWRZI9qhjI1dFd8C5GBStyR69y0ziVIsSVd1
	 yqDj2LQfzR9Oaf7pX8Ursh6V13jRfxdjabBri3V+rh3xgnHogkX2YOr8RrS0VFh3c1kJL
	 CChHHWPNawflrhFLP44Ksl3SEF1Z4SWW6Oz1akqEV7eVUiE97eapmUsViD85exH3yJsj2
	 q2giS0Ept5cGwYnKzOMKpyFmUykrUJgJgfwb3PE1arSZ+06QAfULqzALYe96LzjlABg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568515;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=2piLi41ySfDZ1JYIR+sCK/NscZWfA+RDprm3gX5uBVo=;
	b=e/ICkWDwEKmMfWRSYWcoisyfHv1cVRcK1NM2YnE0IWupegb5T0KsOlZftaYLn5GLXWjR
	 tkCw8a6OIW06Ai8wZvJT8MC7VCV/vwfTA+ybTKcdkVJftEI1/MWS31dwAXtCZiEEE2TnC
	 0+XMUkwOSCCnNFw2cTvJCNrs2tRJpTUEaqP3QaPi4BOvDOo6zVR/PwBsOyxoMe1DBlN0f
	 GCFxsWmOvfma/ZzjHVp/Ci5BFnXh0VhBevfSGtSy1r3hwHZIcY4d8WHO78ijHluoKwu/j
	 fexs1OHJToOEF+iGfs4eaCXUY3UzEsMtU2KcMK7E9dbuzfjpCnrJnpacO6nOhdlpvIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BibRGeBP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YrrWI0DS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB0606A89F
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 11:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31CB0606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BibRGeBP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YrrWI0DS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794568514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2piLi41ySfDZ1JYIR+sCK/NscZWfA+RDprm3gX5uBVo=;
	b=BibRGeBPZ7ozJnb9HZQxEnuVQD56jd6D3LzuI2LpRuK7IMLgF6/ThpHwQVifYDyaBu9D6E
	5ApmkPsGKiasu0Hkswf1VdBs0zzHVMGqPPZrU8qgZ0FfIPn2W592al0k9uGdok2YbmEqmL
	g8jr9RCaxaCQSeH18hNaMNJlBn4PMoY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-O6nm6g93PlGqdWl0NTVdfw-1; Fri, 13 Nov 2026 06:15:12 -0500
X-MC-Unique: O6nm6g93PlGqdWl0NTVdfw-1
X-Mimecast-MFC-AGG-ID: O6nm6g93PlGqdWl0NTVdfw_1794568512
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4ba078abd70so4915665e9.3
        for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 03:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794568511; x=1795173311; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2piLi41ySfDZ1JYIR+sCK/NscZWfA+RDprm3gX5uBVo=;
        b=YrrWI0DSsRNMtlXCjenP4g+N/60+gs3HfWlt7q042Q1UMBu/GuoRCzQnM1o68NiRXw
         O6wjdw8YmAaI+LDiOi1GfZ2DbknYyJVh1lYKDeqfSym7/86ZF0hF6K1u56rTu1UNa1bg
         Mmz73odfPZFQ9hSRJc576/0QIYgFZ0+W8DpX+VEhwaB78QgapQPgZwrFZVJytzUTiiF3
         9WNhyCyrkczNx5EK/t8ReOwH5oI7agbc031d8cGVXSgYJw2+RPWZz5IwoApy1LsxVybI
         KsqrM5b6LLka/2fEw0cw9lvfy5f1OCJVgYICJ8q/QBM0kZNcAku4dhvubyG64rQY0htk
         kBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794568511; x=1795173311;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2piLi41ySfDZ1JYIR+sCK/NscZWfA+RDprm3gX5uBVo=;
        b=Vc9u117YwMQ5C1NNt6X0TD+sywPwt5A3LHK7TnTtkGsCRn0FScXtD89EFxuHxKx/V9
         bsVwp/opJkSCxeBURMBBbSc7HsSUwJbTAoEAh7l2aU0w6wJWCNGagiXxBiXQ77QcqjTD
         p7tcBekURxV5uIbDtl7A9Viu0Vj9R51PsoMI+8v33yMNqGpCsWcHWJXcQRH030HMAlJ6
         eTrMGOqOyGw94UjdRiNv9Js0ZpMBJzasI3UP7mgWbb3cTJD6KQjFNM0oHkneAgvZ05RS
         qDIUvEyQmAHeeyNP5IrdYcoOgqUlVkuCosr6fdCTGp2sROvVBgq3crokLNSp+L5D2pBn
         neKA==
X-Gm-Message-State: APuU4Z8tx8KGO6XqkgMy4wuyeY1bsCqFiy1Ibr6ncNfi1q/CzN+CUhR/
	WwMOaNQoPnQwhZChe103dYrs+H+dn8webu++qx3kh/j3FsVfUjxjWsQchkBNEqMVp6NS8MC9D9f
	RMCdp8XpLHBueUxIaMnKTYMIFDMdDtU0Wuu0SF2UQGh0Agmt/cWAfk4r+kWVW6Q==
X-Gm-Gg: AYBFou3kQsY5gcr6sHwYYSetCuDvFgWclPVtuJK1ebvSB+l+f5AcKEAYdO+uUwcxOnu
	h4R+9xB/uO/685ANc2K8DDKJ+753IDUjlNBfUr/qPCNJvp+e9FMMu1xVnhKg+Mu0tC7ACQ6uzP8
	2uKs8ieaxHTZqCvy1xlpKyN3Zb0wjhdttdfp0ZCbR74SrP9Bw3s4eDEnBs5yIfdz1qi3KQUp7Ad
	WB+KlC7IFWTu9cxM6scQx8P9UITFO4fRz/g/41ldLMTBjEmtDnaMb9uJcImoetVb9V6baxTl3LO
	dKi+g0nqQ3x4SXJ8Lnj+QdZ9pI5Cdb1VGCHKDR1qcEXJ3UxqG3cC0QBE0ESHAIrxrmiYmK53sGX
	jIA4CoonYwDeKUnANIBvwCUzUvottENOBoPMxo2fNZ3m+ePIVoHOhhols8EedWTHxTAWI6zOLmC
	jLv4GmOuL5BS2B
X-Received: by 2002:a05:600c:470a:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4bb55a44996mr40299375e9.11.1794568511539;
        Fri, 13 Nov 2026 03:15:11 -0800 (PST)
X-Received: by 2002:a05:600c:470a:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4bb55a44996mr40298605e9.11.1794568510875;
        Fri, 13 Nov 2026 03:15:10 -0800 (PST)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([130.25.253.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56f8d054sm29531115e9.3.2026.11.13.03.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:15:10 -0800 (PST)
From: Filippo Storniolo <fstornio@redhat.com>
Subject: [PATCH can-next v4 0/3] Introduce diag support for CAN
Date: Fri, 13 Nov 2026 12:14:32 +0100
Message-Id: <20261113-feat-can-diag-v4-0-c28842c74c95@redhat.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNOw7CMBAE0Ksg1xit1/lScQ9E4c86cUGC7CgKi
 nJ3jJuIUI5m3+zKIgVPkV1PKws0++jHIYXifGKmV0NH3NuUGQJWUGLLHamJGzVw61XHba2MdiU
 hGmTJvAI5v+S9O/teDbRM7JGa3sdpDO/8aBa5z5uVgMPmLDhwQEHSiUoKBbdAtlfTxYzPPDXjz
 huojhwTbySWbU1UGN3+cbnzFoojl4lra0g7qLWs5Q/ftu0DKYRpvjMBAAA=
X-Change-ID: 20260529-feat-can-diag-d7acbf5e22c2
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, 
 Filippo Storniolo <fstornio@redhat.com>
X-Mailer: b4 0.14.3

In the current state of the art, it is not possible for userspace to use
tool like ss(8) to query open AF_CAN sockets.

This patch series adds the netlink can_diag interface for AF_CAN. Userspace
is  now able to send a netlink request to request information about open
AF_CAN sockets that are retrieved by the can-diag.ko module.

Patch 1 is a fix that is mandatory to the correct behaviour of the diag
module: the field sk_protocol is not assigned during `can_create()` instead
of being assigned only in case the CAN socket belong to the j1939 transport
protocol. This is needed to the correct filtering of the can diag module.

Patch 2 introduces a list per network namespace containing open CAN sockets.
The list is protected by a mutex.
CAN sockets are added in `can_create()` to the list and removed from it
in the `release()` calls defined for each transport protocol.

Patch 3 is the core patch that introduces the userspace structures to query
and receive netlink messages for CAN sockets and the actual CAN diag module.
The latter will use the userspace structures defined in <linux/can/diag.h>
to filter and retrieve open CAN sockets.

In the current implementation, every CAN sockets in the list is
returned to the userspace, however a filtering could be implemented:
Userspace could possibly request only bound CAN sockets or CAN sockets
belonging to a specific transport protocol (raw, iso-tp, j1939, bcm)
and so on.

An example of the output given by ss -cQpe:

Netid       Local Address:Port  Peer Address:Port  Process                                                                 
CAN_ISOTP           vcan1:1110         vcan1:291   uid:1001 ino:50324 sk:0 users:(("can2",pid=9210,fd=4))                 
CAN_ISOTP           vcan1:291          vcan1:1110  uid:1001 ino:50323 sk:0 users:(("can2",pid=9210,fd=3))

---
Changes in v4:
- Rebased to latest net-next
- Implemented context-analysis and tested using clang-23
  (Marc Kleine-Budde)
- Commit messages now always target "can:"
  (Marc Kleine-Budde)
- Removed "depends on CAN" in Kconfig (Marc Kleine-Budde)
- CAN diag now uses `name_t` and `pgn_t` instead of
  `__u64` and `__u32` (Marc Kleine-Budde)
- Added my Signed-off-by on the 1st commit
  (Marc Kleine-Budde)
- Link to v3: https://lore.kernel.org/r/20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com

Changes in v3:
- Rebased to latest net-next
- Changed no-op functions from #define to static inline
  (Marc Kleine-Budde)
- In struct can_diag_req, sdiag_protocol changed from
  __u8 to __u16. Padding changed accordingly
- Added	CDIAG_SHOW_UID filter in UAPI header and implemented
  filter as netlink attribute in diag module.
- Split sockaddr_can into individual netlink attributes
  for isotp and j1939 respectively, instead of binary-encoding
  it into a single attribute (Sashiko-bot / Marc Kleine-Budde)
- Fixed indentation in /netns/can.h (Marc Kleine-Budde)
- Link to v2: https://lore.kernel.org/r/20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com

Changes in v2:
- Rebased to latest net-next
- Added a patch, suggested by sashiko-bot, that fixes an attempt
   to lock an uninitialized mutex
- Link to v1: https://lore.kernel.org/r/20260610-feat-can-diag-v1-0-021e3f1631a0@redhat.com

Change w.r.t. RFC:
- header relocation, from linux/can_diag.h to linux/can/diag.h
  (Oliver Hartkopp)
- file renaming, from net/can/can-diag.c to net/can/diag.c
  (Oliver Hartkopp)
- guard renaming, from _UAPI__CAN_DIAG_H__ to _UAPI_CAN_DIAG_H_
  (Oliver Hartkopp)
- handled J1939 addressing in sockaddr_can
  (Oliver Hartkopp)
- Link to RFC: https://lore.kernel.org/linux-can/20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com/

---
Davide Caratti (1):
      can: ensure sk_protocol is always set on socket creation

Filippo Storniolo (2):
      can: store socket pointers in struct netns_can
      can: add can diag interface

 MAINTAINERS                   |   1 +
 include/linux/can/core.h      |  11 +++
 include/net/netns/can.h       |   6 ++
 include/uapi/linux/can/diag.h |  50 +++++++++++
 net/can/Kconfig               |   9 ++
 net/can/Makefile              |   5 ++
 net/can/af_can.c              |  54 +++++++++++
 net/can/bcm.c                 |   2 +
 net/can/diag.c                | 204 ++++++++++++++++++++++++++++++++++++++++++
 net/can/isotp.c               |   2 +
 net/can/j1939/socket.c        |   3 +-
 net/can/raw.c                 |   2 +
 12 files changed, 348 insertions(+), 1 deletion(-)
---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
change-id: 20260529-feat-can-diag-d7acbf5e22c2

Best regards,
-- 
Filippo Storniolo <fstornio@redhat.com>

