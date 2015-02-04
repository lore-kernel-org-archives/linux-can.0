From: Mike Purvis <mpurvis@clearpathrobotics.com>
Subject: Standard CAN over IP
Date: Wed, 4 Feb 2015 15:27:19 -0500
Message-ID: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:57879 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161337AbbBDU1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Feb 2015 15:27:40 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so6827255igb.5
        for <linux-can@vger.kernel.org>; Wed, 04 Feb 2015 12:27:39 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

I'm interested in providing low-cost CAN connectivity to a standard
Mini-ITX PC=E2=80=94 so USB, Ethernet, RS232, PCIe connectivity is avai=
lable,
but not I2C or SPI (at least easily).

I'm interested in any proposals for how to achieve this, though the
idea I have in mind is basically a simple microcontroller which
provides a CAN-over-UDP bridge. But I'd like to stay away from writing
a kernel module to actually present the UDP traffic to the linux
system as a socketcan can0 device. Is there some standard component
which already does this, or at least some tooling around serializing
CAN messages to a bytestream?

I noticed an interesting past discussion on this topic:
http://socket-can.996257.n3.nabble.com/Socketcan-over-ethernet-td1203.h=
tml

Have anything changed significantly on this front since 2009?

Thanks,

Mike
