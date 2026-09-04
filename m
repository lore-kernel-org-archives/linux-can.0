Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFD4AA59B
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531238; cv=none; b=FfqxUVXYkUWtQMGI4tJXw62otdPYCwyKAsXslGtGd1dSjSxoWPhalp8ZIMeq6g/NbvNm2hiexwYJvCco/fKj4oHD+j759ZQGtuBnbO5Bj+Xt7yc3OhuYl93/sXwv0j73QerENU9P+f20EZ3fbheAaynUG4F87xsvmyPK6uLY3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531238; c=relaxed/simple;
	bh=Mv3TXxdu7AUWdWzmN9r5SAgW7QcwG9dVJkrQkrRiedE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IN7yvTeDDisQgspow+1a28Z6+9PCDXH0l21gQ4uD4rmubkKiuL19HL+aai5yPIopCpPWMY94O7gIbFw9m3gVN5i7QnaEstNZ19fkB7wJL0nxIncAcSX7RRe8EXY+h1VQll5Qh5PGYxPN/BKmdb87l8FBqk+k6awO4MSnlcMD6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcQA9xyz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zo1a7pR7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcQA9xyz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zo1a7pR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788531235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tX5JJNw2DrI3K7W6ElOQ8mjngFzbcc0mbqMukw0+T3I=;
	b=bcQA9xyzoe/nkYYNTfeqrBDXdF3N5rU8rBhjUA3M8uAepIwe4zjYQn/4xGJDTM5td9NiI+
	B1z4IZuGDHO9H0n9DHvj1wk5mDJAIAU3jNO9aiU3H1OzYvJG3/TRfVS1EhnvHiihaCsor0
	0DCMZFdxHj6DGBITcrrR+XzZvmnHHDQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-k00jYgnXMtWuajsCuEpmlA-1; Fri, 04 Sep 2026 10:13:52 -0400
X-MC-Unique: k00jYgnXMtWuajsCuEpmlA-1
X-Mimecast-MFC-AGG-ID: k00jYgnXMtWuajsCuEpmlA_1788531231
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-484337a63bbso672924f8f.3
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788531231; x=1789136031; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tX5JJNw2DrI3K7W6ElOQ8mjngFzbcc0mbqMukw0+T3I=;
        b=Zo1a7pR7ZZqpvxfQNwRJC1MhoXqENaZExXhgcJzzgCvd/+E5qafHVYvwkXhnAWQB8t
         4Dx2Z9VTfqO3lQa7zIZ/iVaCIKojJ7HzPSaS7JBkQ+GTJftOmQcmaXr4ow2/3R4TkIXg
         FFDXS4CqckqoSDvMCnBOOsKwqvKb/A1zCCjWRk4rWBav7JzKTebNpJ7G37wE+hivpQbF
         1XQ5Br7h/NgDGTTlWmW4jhraoNdx5Cin4YpFrZKJit1YtUHpCubL5p098on8KYCzXuW5
         NyogfOsIm2ES5i8kXXGY1Kn7hqHttb8oUIR0UqD0jBQXnrs8QNHYXj4ceS3Azwn2/0cd
         O1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531231; x=1789136031;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tX5JJNw2DrI3K7W6ElOQ8mjngFzbcc0mbqMukw0+T3I=;
        b=sZFSrIXCc5XgtJBUxq/EAwL4CE5BSksIxSX+ryWXXuE9xzzco7SdoSiGhsV0OuBW18
         ERVXk0/B24d27UROFkeHhqrB8lZpqvSwcARyVj30sLdiFtq4WPxg4IvY5Kn7WF6vh7kn
         +OCLocVjcaKQ8jb51RDPMPJc4xgoKqpEQCvg1+qpRAgS+1+/bPB8Run7o1B3KrKf5kET
         Jt3FvyijZbq1NH9Jjqppj86wMrgoA0DLILXimDx1zfz1WCejXDH9dEk09qDgg6PtMvQw
         9JnUp0HgoJruT75OThTcrgRGByL/tmWcasQ5sI/5a6hyGBfgbCxJkcteKe27wv3fQ4H6
         fOow==
X-Gm-Message-State: AFuF++leEt6ywYRpqKRF0MPHVh0jchpRKRuMA/IoLKbM0I7XMYhYTZo3
	kmt+58Ry6BTXPVD/Qs29T1fGOLh3aLgokXx9vHGf7N3cj9YfsSpPSvdPMqIISIj8NZ1K/TJxK+s
	wqnMKiX7Zqm7nM0lJYG7dYVheTBlfCbOQL4eaHjfsYwC2OBPCiA/+6QTiybLwfQ==
X-Gm-Gg: AYBFou06vYrnhge9TMQOc0hE7RkFY6jJwWPOTyUjkRN7ZQdW4DXTgKxsrjuqpqiUW6k
	USwZGBNirvERzQFAyVtEevKro4zTetk/p+kcBTADlQQ5SIhsBKxhY57Z5FNy42ddZy3RBXmHVY/
	io0n2OEuYQhfzVlVuLLejQGdPYvEOZ9gHvXdBIj0l+NnXopdUBotMQsXgTswim8S7SIlazqKmMJ
	WZL7qbrq76UfUoHh1xfRyVDWpnTVeoi+AljdYRha6DHTWsVJNsJpeS0wo8L4z5ev6tQ3rnw6i43
	h114J9VW23QYEVGZrf6YYDfY/8SV4kwYDTtnmitiuNxTSfC+MOOhlsNu0d0Aqylpw9VQBKmpWH3
	tgltYKzmqfbH8pbkpy0exhXXw
X-Received: by 2002:a05:600c:348a:b0:49c:fa20:cc03 with SMTP id 5b1f17b1804b1-49cfa20ccedmr39647845e9.26.1788531231397;
        Fri, 04 Sep 2026 07:13:51 -0700 (PDT)
X-Received: by 2002:a05:600c:348a:b0:49c:fa20:cc03 with SMTP id 5b1f17b1804b1-49cfa20ccedmr39647205e9.26.1788531230818;
        Fri, 04 Sep 2026 07:13:50 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb ([130.25.253.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm99744845e9.5.2026.09.04.07.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:13:49 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Subject: [PATCH can-next v3 0/3] Introduce diag support for CAN
Date: Fri, 04 Sep 2026 16:12:54 +0200
Message-Id: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ7CIBREr9KwFgMfS1tX3sO4oPBpWUgNEFLT9
 O4iG2OXk5n3ZiMRg8NIrs1GAmYX3eJLEKeG6Fn5CakzJRNgIFkLA7WoEtXKU+PURE2n9GhbBNB
 ACvMKaN1afXfyXXlcE3mUZnYxLeFdjzKvfXVKzg7OzCmjDDgKy6Xgit0Cmlmls16eVZXhh/dMH
 nEoeC+gHTrEix6HP3zf9w8/5gTj9AAAAA==
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
      af_can: ensure sk_protocol is always set on socket creation

Filippo Storniolo (2):
      af_can: store socket pointers in struct netns_can
      can: add can diag interface

 MAINTAINERS                   |   1 +
 include/linux/can/core.h      |  11 +++
 include/net/netns/can.h       |   6 ++
 include/uapi/linux/can/diag.h |  50 +++++++++++
 net/can/Kconfig               |  10 +++
 net/can/Makefile              |   3 +
 net/can/af_can.c              |  51 +++++++++++
 net/can/bcm.c                 |   2 +
 net/can/diag.c                | 203 ++++++++++++++++++++++++++++++++++++++++++
 net/can/isotp.c               |   2 +
 net/can/j1939/socket.c        |   3 +-
 net/can/raw.c                 |   2 +
 12 files changed, 343 insertions(+), 1 deletion(-)
---
base-commit: 6ebcf5074cff0402730c6981d2397139fee6322d
change-id: 20260529-feat-can-diag-d7acbf5e22c2

Best regards,
-- 
Filippo Storniolo <fstornio@redhat.com>

