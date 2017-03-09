From: Lars Susaas <larssusaas@gmail.com>
Subject: How to get device supported ctrl modes from userspace
Date: Thu, 9 Mar 2017 21:38:22 +0100
Message-ID: <CALHGA=t6cpsOBM11Uz4oj9wO-V2ri6cKPGwSRagUXJTfbbQQ0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35622 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdCIUiY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 15:38:24 -0500
Received: by mail-pf0-f170.google.com with SMTP id j5so32877157pfb.2
        for <linux-can@vger.kernel.org>; Thu, 09 Mar 2017 12:38:23 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I would like find out how to get information about which control modes
the device supports from userspace.
Ctrlmode as in CAN_CTRLMODE_LISTENONLY

In the driver code is looks like it is found in
priv->can.ctrlmode_supported, but how do i get it from userspace?

I am unable to find any information about this.

Lars
