Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52256386C08
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023350; cv=none; b=U21LLVgh8rVFX9S04f45VZz13/uZbBS+TkwDsgbV6/Iftei/MxbY9l2SvT7hdF0ae7lla/uw0GW2KeJNlTZ5M+czHLmvHnKJNyjBtvUcmlRjJp9oNsR/YqAl4jQOIeKhPVnOGdJSnhIUw0260K4GO07ucjDFY7hY/jp7lGPDwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023350; c=relaxed/simple;
	bh=AB0H0csc8nT5ilL/p/Hf7kL2DMotPvGjez6WD0tewOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TJGROgKcVU54Sv0ZPKdKNv7m0LsPC7UkCJF8yR40epvDgxy3U/+VN25LynXhS1NimZJMDT8/gVm6IavTDBGIPHadvYaEscSJ5vIjHTM7JWlpGBkRpATEQXCdXiRZN/eH2hQdTe0LAD3/6YCc8rpJyeXRFEEDF5zp2PLueXaqxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACyVu+Ny; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rEnzHEmB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACyVu+Ny";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rEnzHEmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786023340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FxAW3R7rmtFB4psXZLRBVsjJwlc9eaj9FZVMiKAbwWA=;
	b=ACyVu+NyEEaWEbS0Fg1pJ/UN8V4ZbRTuACKB7nP19Vz5Yco/5UlJ1rYYyPhfVBjY5KB3op
	MMnuXJtCd3qQOh7aeuFwqdMrtUMZOnq/xgiJ1rE6YKjqKKhpdPcoIyUF9XKiFy/wRQaaY+
	IS37zNrw2TpwLWTBK0tqmvlUmCtu3n4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-7URrhpLBNsqM6XbBV6kt1w-1; Thu, 06 Aug 2026 09:35:37 -0400
X-MC-Unique: 7URrhpLBNsqM6XbBV6kt1w-1
X-Mimecast-MFC-AGG-ID: 7URrhpLBNsqM6XbBV6kt1w_1786023337
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fecbb7f88so1296439f8f.0
        for <linux-can@vger.kernel.org>; Thu, 06 Aug 2026 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786023337; x=1786628137; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FxAW3R7rmtFB4psXZLRBVsjJwlc9eaj9FZVMiKAbwWA=;
        b=rEnzHEmB5dRyeIFRRPa9Mo7/fbKQOBBSa0i7a/wC/wMkDxWyfKs+KPIL7r0BqEjOES
         wMeri8cVoeCHOxkjH7fRJXFZikK4HJ+pcL8qNBVjcpT2x3+5IF1/Z86Ac3HA3yzSnL2J
         DQtaLjlhsPoBJKPRaWj4sXaDIlUUfEcnPAvWvMR0o2RqzStYWsP/9nbQcMkw683GT+A0
         UWknsTdNDd+H1iCvjkbmL4Z/BihjzX2/wkHwPo2Aa1F5PiFzg6/tysj7TOLEDQ0QFLln
         ave75Vo/mz4cOrh00eOFHyLL5ZsUI0kOLzQ36vfSuWGWBB8uRVgrh60myKJM8MBC8U4H
         XT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023337; x=1786628137;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FxAW3R7rmtFB4psXZLRBVsjJwlc9eaj9FZVMiKAbwWA=;
        b=GABDcvnRHDjvRbbQtwAFCxHXWmHEgur1R2Mv2riVYzwjH0Chyb9dpsRWa4z7RJgSlD
         jGalMgAzxEASCF8t/kFtjRxR6M4kQg1rc48fbl7bW7CnbvNjuc6uRmrbXbUM3Mb+lk5/
         xEEIsal4715E7jZy0LbRCzUb96Wm9cX3+JEbejaE+NX5uBWaK8JvIsprpOJFdjql2P2C
         1jd5TBAUqOlxapGb5hmlIkRoJbwods0eUQ0OherMFkFZHxx9R+7CMF80FQVi/bz7Fn+I
         mlkfFvJZo3AHdfhHLTQJqQv7fJrhQ4XwLkcIymn6PpetprdE9d6mYQOw32+2+yPpqAkw
         YLqA==
X-Gm-Message-State: AOJu0YxVcuInYMkl98mOPzq5FqAuGqCb1zpakTsIT93ObgbofDd2mStv
	7Il1pH/n5GK/YGKu3pj1WLmV9kHIJCBgjwt7nn5s83YDvIWEoePAzX2iglducm/+H8Hin1FbvO8
	Rwmb5QGRO93Qm2JGVFrwgx0sOpYg5RDbFjY9whGXo61TTr4Z9VIiGPMcKkTGObQ==
X-Gm-Gg: AR+sD10fX9mvXHyywQCZgBr2qtSzdOHdQ2tV0TZp/cEwp4rnyeFWGIsVDv6jOKGWPPg
	+0S6vlqWdBz9HPeylkisTwHQ3Dc71ZeII9baWSn9/LOG1tjOHxStXRXZTUe3mHC9JFPu3mI6iA5
	9nrefcjTlalncaheU1ShJLfw7Q43oDnISKI7RHecnMrh7YwTYfpnOu20PhXrXFO79SGgRoGzp9S
	ck4BISaYUI5Q+MFuS4O8UyZ8sh2iVR6q3QPNTELqRlUzQV21BHEON8Yami7Ok6V63QI9e+H71w7
	iyLgH6wHu63ESUPcukAlZtpkni5wnjVN6jgcqBHUjoePvnvbtTunSDj9K50DdptKQTk/vgPZmJG
	z6egl+GpY1WUEA5tlBMJN/Sak0PXWbsOPqA80Tjebb4Fl9LWZde5z3fZInS3WPPX/AFi4Ly0Z3G
	DJaJfLlA==
X-Received: by 2002:a05:600c:354c:b0:499:51cc:4e57 with SMTP id 5b1f17b1804b1-49951cc6d0fmr134707855e9.0.1786023336665;
        Thu, 06 Aug 2026 06:35:36 -0700 (PDT)
X-Received: by 2002:a05:600c:354c:b0:499:51cc:4e57 with SMTP id 5b1f17b1804b1-49951cc6d0fmr134707035e9.0.1786023336148;
        Thu, 06 Aug 2026 06:35:36 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (host-87-1-27-205.retail.telecomitalia.it. [87.1.27.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954246f9dsm75112735e9.15.2026.08.06.06.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:35:35 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Subject: [PATCH can-next v2 0/3] Introduce diag support for CAN
Date: Thu, 06 Aug 2026 15:14:12 +0200
Message-Id: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ7CIBBEf6XZsxjYpjV68j9MDyss7R6kBgipa
 frvIkePkzfzZofEUTjBrdshcpEka6gBTx3YhcLMSlzNgBpHPeBVeaasLAXlhGblLmSffmBEi1A
 378hetuZ7wK8VeMswVbJIymv8tKNiGm/O0eg/ZzFKK42Ge2/G3pC+R3YL5bNdXzAdx/EFEwULS
 LUAAAA=
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

An example of the output given by ss -cpe:

Netid                     Recv-Q                 Send-Q                                 Local Address:Port                                   Peer Address:Port                 Process                                                                 
CAN_ISOTP                 0                      0                                              vcan1:1110                                          vcan1:291                   uid:1001 ino:50324 sk:0 users:(("can2",pid=9210,fd=4))                 
CAN_ISOTP                 0                      0                                              vcan1:291                                           vcan1:1110                  uid:1001 ino:50323 sk:0 users:(("can2",pid=9210,fd=3))

---
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
      af_can: ensure sk_protocol is always set on socket creation

Filippo Storniolo (2):
      af_can: store socket pointers in struct netns_can
      can: add can diag interface

 MAINTAINERS                   |   1 +
 include/linux/can/core.h      |  11 +++
 include/net/netns/can.h       |   6 ++
 include/uapi/linux/can/diag.h |  55 +++++++++++++
 net/can/Kconfig               |  10 +++
 net/can/Makefile              |   3 +
 net/can/af_can.c              |  51 ++++++++++++
 net/can/bcm.c                 |   2 +
 net/can/diag.c                | 185 ++++++++++++++++++++++++++++++++++++++++++
 net/can/isotp.c               |   2 +
 net/can/j1939/socket.c        |   3 +-
 net/can/raw.c                 |   2 +
 12 files changed, 330 insertions(+), 1 deletion(-)
---
base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
change-id: 20260529-feat-can-diag-d7acbf5e22c2

Best regards,
-- 
Filippo Storniolo <fstornio@redhat.com>

