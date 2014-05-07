From: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Subject: share thought on socketcan for flexcan driver on imx6 platform
Date: Wed, 7 May 2014 17:46:08 +0530
Message-ID: <536A2408.70608@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [207.46.51.122] ([207.46.51.122]:10847 "EHLO
	APAC01-HK1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbaEGMTG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 7 May 2014 08:19:06 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi All,

The mail I  write  to get more insight on socketcan implementation for 
flexcan driver on imx6 platform.

Our customer need mode change implementation to be implemented on the 
driver.
Freeze -> Listen-Only
Freeze -> Normal
Listen-Only -> Normal
Normal ->Freeze
Freeze -> Disable
Disable -> Freeze

I very well know this can be achieved with iproute2 utilities with the 
existing driver implementation.

I can also tweak the driver code to bring in this mode changes with the 
implementation of ioctl calls,the thought bothers me to go ahead is this 
changes with lead to undesired consequences on socketcan stack.
for example debugging an application with ipoute2 related commands will 
not give the correct status on the on below stack below when the mode 
changes occurs at the c code level.

So I need to understand any better way to achieve the scope apart from 
command line tools, probably by enhancing the upper layer stack to 
accommodate the mode change ioctl implementation.

I will be great help if you all can share your valuable thoughts.

Regrads,
Ratheendran

