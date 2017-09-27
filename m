From: Jimmy Assarsson <extja@kvaser.com>
Subject: Implement new Kvaser USB driver, where to start?
Date: Wed, 27 Sep 2017 15:54:31 +0200
Message-ID: <4a46b81e-1073-8a33-e674-d43c8579985a@kvaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:53534 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdI0Nyf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Sep 2017 09:54:35 -0400
Received: by mail-wr0-f174.google.com with SMTP id 54so2001771wrz.10
        for <linux-can@vger.kernel.org>; Wed, 27 Sep 2017 06:54:35 -0700 (PDT)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

We are in the planning stage of writing a new SocketCAN driver for our 
latest
generation USB based CAN interface platform (minihydra). Currently we try to
estimate the work effort for implementing the driver.

The communication protocol is slightly different to our former platform, 
leaf
(which is already supported by SocketCAN). The minihydra platform also 
utilizes
CAN FD. I assume that it is preferable to extend the current driver, 
kvaser_usb,
rather than implementing a second?

I've studied Documentation/networking/can.txt and glanced through some 
of the
USB based SocketCAN drivers in drivers/net/can/usb.

Do you got any suggestions on where to start?


Best regards,
Jimmy
