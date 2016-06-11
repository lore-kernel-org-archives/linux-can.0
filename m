From: Hubert Denkmair <xor@xor.wtf>
Subject: "user id" for can usb adapters
Date: Sat, 11 Jun 2016 15:03:06 +0200
Message-ID: <575C0C0A.60903@xor.wtf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.xor.wtf ([46.38.236.187]:43652 "EHLO mail.xor.wtf"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbcFKNDO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 11 Jun 2016 09:03:14 -0400
Received: from p200300d113c51d00043894f8642bf5f3.dip0.t-ipconnect.de ([2003:d1:13c5:1d00:438:94f8:642b:f5f3])
	by mail.xor.wtf with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84_2)
	(envelope-from <xor@xor.wtf>)
	id 1bBiZ7-0006OO-PJ
	for linux-can@vger.kernel.org; Sat, 11 Jun 2016 15:03:06 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi all,

for my candleLight adapter (gs_usb driver), I would like to implement a feature which is afaik currently not used in linux / socketcan:

A device ID that the user can assign and store permanently on CAN interfaces, e.g. a USB CAN interface.
This is not new - e.g. Peak System implements this in their Windows API.

One use case would be to build multiple measurement setups, each with more than one CAN adapter.

For example, at my company, we build test racks with several CAN interfaces.
Each test rack should run with the same (unmodified) software image.
To be able to build a stable environment, devices shall have a predictable name in each rack.

One way to achieve this would be to
- assign "user IDs" to the CAN interfaces (e.g. CAN A = 0, CAN B = 1, ...)
- have this id exported, e.g. as a sysfs attribute
- use udev to assign defined names for can interfaces with a certain id

Implementing a sysfs attribute for one driver is easy - and I did that for testing purposes.
But since this is (imho) a feature which could be useful for the whole socketcan infrastructure,
I would like to see a standardized method for the functionality.
We should also implement this in the pcan_usb linux driver.

I am aware that there is a file /sys/class/net/<device>/dev_id - but no idea if that would be the right place.
Seems to me as if adding a new sysfs attribute like /sys/class/net/<device>/user_id would be a better way to go.

So - any opinions on this?

Greetings,

Hubert
