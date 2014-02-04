From: "Sandro Anders | CarMedialab" <sandro.anders@carmedialab.com>
Subject: AW: netlink error -95 (Operation not supported) with can-utils/cangw
Date: Tue, 4 Feb 2014 11:55:50 +0100
Message-ID: <18F8639CFC8C7C4D819AB347808079D4026C69FC@pluto.office.rac.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rac.de ([213.144.11.11]:37938 "EHLO mail.rac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbaBDKz4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2014 05:55:56 -0500
Received: from pluto.office.rac.de (gate [213.144.11.9])
	by smtp.office.rac.de (Postfix) with ESMTP id BEF116084E
	for <linux-can@vger.kernel.org>; Tue,  4 Feb 2014 11:55:51 +0100 (CET)
Content-class: urn:content-classes:message
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

I was able to compile the can-utils/* apps without any errors and the
most are working. But if I call the cangw command I get the following
error message: cangw -A -s can1 -d can3
netlink error -95 (Operation not supported)

Both CAN's are up and running. My assumption is that there is some
netlink support missing in my Kernel, isn't it? Thanks for your help.

Sandro 
