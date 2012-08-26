From: "Max S." <max@schneidersoft.net>
Subject: usb-can device
Date: Sun, 26 Aug 2012 15:52:19 +0000
Message-ID: <1345996339.6610.10.camel@slaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:56597 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab2HZP7l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 26 Aug 2012 11:59:41 -0400
Received: from [192.168.1.39] (unknown [187.90.28.208])
	(Authenticated sender: max@schneidersoft.net)
	by mail.schneidersoft.net (Postfix) with ESMTPSA id 3BA6C1A32C
	for <linux-can@vger.kernel.org>; Sun, 26 Aug 2012 15:54:34 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I am developing a usb to can adapter.

Does there exist a standard usb-can interface on the linux side? Or will
I have to create my own device driver?

In the linux kernel source I see drivers/net/can/ems_usb.c which seems
to provide a way to add support for multiple devices through the
ems_usb_table. What would it take to get my vendor id and product id
into this list (assuming that the device is working with this driver).

I haven't studied the driver in great detail, so i don't know if it is
appropriate for what I am trying to do...

What are my options for getting a usb device, that exposes two can
nodes, supported under linux? I have complete access to the usb device,
so it would not be a problem for me to build a firmware that behaves a
certain standard way.

Respectfully,
Max S.


