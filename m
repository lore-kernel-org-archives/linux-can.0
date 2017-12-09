From: Martin Sperl <kernel@martin.sperl.org>
Subject: Can: FD: configure transmitter delay
Date: Sat, 9 Dec 2017 18:01:33 +0100
Message-ID: <B4DF4571-1790-4F09-8DEC-C0812D0F34B1@martin.sperl.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:43702
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdLIRBh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Dec 2017 12:01:37 -0500
Received: from [151.127.2.249] (account martin@sperl.org HELO [10.4.147.44])
  by sperl.org (CommuniGate Pro SMTP 6.1.16)
  with ESMTPSA id 7521038 for linux-can@vger.kernel.org; Sat, 09 Dec 2017 17:01:34 +0000
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi!

The mcp2517fd that I am finishing the driver for has some specific
settings to configure the transmitter delay which is used with can fd 
frames (essentially it configures 2nd sample point that takes the
delay /latency of the transceiver into account -  can be off, fixed, or 
automatic).

Compatibility tests have already shown that some can fd communication
is quite sensitive to these settings - especially between different types
of devices - which may result in BUS off situations...

So I am wondering how to best allow for configuration of these
parameters - module parameters is ugly similarly debugfs or sysfs.

I guess there must be other fd devices with similar requirements,
so I wonder how it is handled there...

Thanks,
             Martin
