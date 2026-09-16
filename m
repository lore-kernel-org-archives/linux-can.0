Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A253D952F;
	Wed, 16 Sep 2026 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565588; cv=none; b=Td/1MbXv26YHeSVwmarIRMpiPokafryBBJaaVSenuUZbS3S/O/CeXgh7LNh/GcWimzxAv7wqsqm/reUBlRj0oWJi3jXOlhoK0XVhFmEGPs1IuX4sJUU0a3pzi8JcnZUsDOflrjA7eeBqlnPG3o8oPKxrnX9hUyXd5G78FSh3uqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565588; c=relaxed/simple;
	bh=MIiQ3yUp247f086TjxlyFtTWSXlWr+K4UuL/JU/XSog=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ngFZjT0XcTtt29q3CSzX+1MHO1+tQqeb2+PE+lg9vZeVYCETicRRGmAMW0xnxcO77fVK2Y1lOH56n86ncFrIacR96e2WnxI3rBYgYm8Gxl0tVOuR1VsMJVxhNaPMrQKLXIzrFOWWnbFNOoSkAtEoU3mUIeY3d8VExS1vCHQOHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=EZVZUT+9; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="EZVZUT+9"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id E141B83467A;
	Wed, 16 Sep 2026 15:32:49 +0200 (CEST)
Received: from [127.0.1.1] (unknown [IPv6:2a02:8428:60a1:3e01:2ba7:4349:5c56:5541])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id B354719F59C;
	Wed, 16 Sep 2026 15:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1789565562;
	bh=MIiQ3yUp247f086TjxlyFtTWSXlWr+K4UuL/JU/XSog=;
	h=From:Subject:Date:To:Cc:From;
	b=EZVZUT+9M30G/l1tMYjua7PtQmKCfBR5Am1O++37Kmy3eRWNAqRdzfPRReCgCZCEB
	 sv6espO2uWsi173k/Nhd9qZ79KDQPMSAjWzhG/7POE610N377c+wnoaxh9nqQyoRCU
	 9yPSg9mdlAkgqv3ikoEnxAbM96+efQy/FDq5ECdkeriFksHWL6M/MI5k324qurUFtu
	 eHBOadlhAoNI6bQYKkUm6f2wzPe2iwdMF4TUFwo6zcmcgprvg1xL3Dw3UW8LTxoQBD
	 gyhvainbsvTTxaAmWQZ4WBx5V3WdsnZdwJt+kfdkgx1TEnYY6psWiJFrEUVfLg06yl
	 FUvecx8TUub+g==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Subject: [PATCH v2 0/3] can: usb: ixxat_usb: add driver for HMS IXXAT
 USB-to-CAN adapters
Date: Wed, 16 Sep 2026 15:31:56 +0200
Message-Id: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDCwNT3cyKisSS+NLipPjkxDxdizSzREuTtETDNANjJaCegqLUtMwKsHn
 RsbW1AB6Fzj1fAAAA
X-Change-ID: 20260805-ixxat_usb_can-8f6a94fa1f03
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.14.3

This series adds mainline support for the HMS/IXXAT family of
USB-to-CAN adapters (USB-to-CAN compact/embedded/professional/
automotive, USB-to-CAN FD compact/professional/automotive/MiniPCIe,
USB-to-CAR and CAN-IDM101/IDM200), currently only available as an
out-of-tree module.

The devices in this family use one of two communication layers
("CL1" and "CL2") depending on the generation/firmware of the
adapter. The series is split so that each patch is self-contained
and independently buildable:

  1/3: adds the Kconfig/Makefile plumbing and the generic USB core
       (probe/disconnect, netdev/ethtool ops, URB and command channel
       handling). No device is matched yet (empty usb_device_id
       table).
  2/3: adds ixxat_usb_cl1.c and wires up the USB-to-CAN CL1 (V2)
       device family.
  3/3: adds ixxat_usb_cl2.c and wires up the USB-to-CAN FD and
       CAN-IDM device families, plus the newer USB-to-CAN/FD Pro and
       Standard adapters.

Changes since v1 [1]:

 - Split the series "the right way up": patch 1/3 now adds the
   Kconfig/Makefile plumbing and the generic core with an empty
   usb_device_id table first, then patches 2/3 and 3/3 add the CL1
   and CL2 protocol layers on top, each patch remaining independently
   buildable (Vincent Mailhol).

 - Replaced the macros used to initialize the static const struct
   can_bittiming_const objects with their literal numeric values
   (Vincent Mailhol).

 - Fixed a heap buffer overflow in ixxat_usb_send_cmd_internal(): the
   response buffer offset computation could write/read up to
   sizeof(struct ixxat_usb_dal_res) bytes past the cmdbuf allocation
   for some request/response size combinations (sashiko-bot).

 - Fixed an out-of-bounds heap read in ixxat_usb_decode_buf(): the
   per-message length parsed from the (device-controlled) first byte
   of each USB fragment was used in memcpy() before being checked
   against the number of bytes actually received in the URB; the
   bounds check now happens before the memcpy() (sashiko-bot).

 - Fixed a u16 overflow in the CAN FD Transmitter Delay Compensation
   offset (tdo) computation in ixxat_usb_cl2.c at low data-phase
   bitrates; the value is now computed in a wider type and clamped
   before being narrowed (sashiko-bot).

 - ixxat_usb_start_xmit() now always returns NETDEV_TX_OK instead of
   propagating a raw error code from usb_submit_urb(), avoiding a
   double-free of the skb by the network core (sashiko-bot).

 - ixxat_usb_start_xmit() now calls netif_stop_queue() when no TX
   context/message slot is available, instead of returning
   NETDEV_TX_BUSY and letting the queueing discipline spin (sashiko-bot).

 - ixxat_usb_read_bulk_callback() no longer skips re-submitting the
   RX URB when ixxat_usb_decode_buf() returns an error, which used to
   permanently wedge the receive path (sashiko-bot).

 - ixxat_usb_write_bulk_callback() no longer skips the TX context
   cleanup on a transient USB status error, which used to permanently
   leak TX contexts (sashiko-bot).

 - ixxat_usb_free_usb_communication() now also releases (usb_free_urb)
   the TX URBs and their buffers, instead of only marking them free
   for reuse; without this, every interface down/up cycle (and
   disconnect) leaked the previous URBs and their buffers (sashiko-bot).

 - ixxat_usb_create_ctrl() now calls unregister_candev() in its error
   path before free_candev(), fixing a use-after-free of the network
   device if sysfs_create_group() fails after register_candev()
   (sashiko-bot).

 - ixxat_usb_probe() now also releases devdata/cmdbuf when the first
   CAN controller fails to be created, instead of leaking them
   (sashiko-bot).

 - ixxat_usb_handle_status() now reads the raw status word with
   get_unaligned_le32() instead of dereferencing a cast (__le32 *)
   pointer into a packed byte array, avoiding a potential unaligned
   access trap on architectures that enforce strict alignment
   (sashiko-bot).

 - ixxat_usb_handle_status() now skips allocating and emitting an
   error skb when the CAN state has not actually changed since the
   previous status message, instead of flooding userspace with
   redundant identical error frames (sashiko-bot).

 - ixxat_usb_encode_msg() now zero-initializes its local struct
   ixxat_can_msg before filling it in, so that no uninitialized
   kernel stack bytes (e.g. the CL2 client_id field, which is never
   set) are sent to the USB device (sashiko-bot).

 - Fixed the commit message of the CL1 patch, which used to claim
   that the exported adapter references open/close/start/stop
   callbacks; only get_ctrl_caps/init_ctrl are implemented
   (sashiko-bot).

 - Fixed a documentation-only math mistake in the comment describing
   how the controller start timestamp is correlated to the host
   clock, and made the struct ixxat_tx_urb_context kernel-doc match
   the actual (in-tree vs. out-of-tree) struct layout (sashiko-bot).

 - Reviewed the "duplicate USB product ID" warning raised by
   sashiko-bot on v1: USB2CAN_FD_COMPACT_PRODUCT_ID and
   USB2CAN_FD_STANDARD_MODULE_PRODUCT_ID do share the same numeric
   value, but they are matched against two different USB vendor IDs
   (IXXAT_USB_VENDOR_ID_LEGACY vs. IXXAT_USB_VENDOR_ID), so there is
   no actual (VID, PID) collision; no code change made for this one.

[1] https://lore.kernel.org/linux-can/20260723072955.32575-1-stephane.grosjean@free.fr/

Comments welcome.

Stéphane Grosjean (3):
  can: ixxat_usb: add driver skeleton for IXXAT USB-to-CAN adapters
  can: ixxat_usb: add support for USB-to-CAN CL1 (V2) devices
  can: ixxat_usb: add support for USB-to-CAN FD and CAN-IDM devices

drivers/net/can/usb/Kconfig                   |   20 +
 drivers/net/can/usb/Makefile                  |    1 +
 drivers/net/can/usb/ixxat_usb/Makefile        |    3 +
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c |  180 ++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c |  307 ++
 .../net/can/usb/ixxat_usb/ixxat_usb_core.c    | 2620 +++++++++++++++++
 .../net/can/usb/ixxat_usb/ixxat_usb_core.h    |  799 +++++
 7 files changed, 3927 insertions(+)
 create mode 100644 drivers/net/can/usb/ixxat_usb/Makefile
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h

---
Stéphane Grosjean (3):
      can: ixxat_usb: add driver skeleton for IXXAT USB-to-CAN adapters
      can: ixxat_usb: add support for USB-to-CAN CL1 (V2) devices
      can: ixxat_usb: add support for USB-to-CAN FD and CAN-IDM devices

 drivers/net/can/usb/Kconfig                    |   20 +
 drivers/net/can/usb/Makefile                   |    1 +
 drivers/net/can/usb/ixxat_usb/Makefile         |    3 +
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c  |  180 ++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c  |  307 +++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c | 2620 ++++++++++++++++++++++++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h |  799 ++++++++
 7 files changed, 3930 insertions(+)
---
base-commit: dc4b95b8fee95113587e93ca116356032d271371
change-id: 20260805-ixxat_usb_can-8f6a94fa1f03

Best regards,
-- 
Stéphane Grosjean <s.grosjean@peak-system.fr>

