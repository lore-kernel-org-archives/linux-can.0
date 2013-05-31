From: "Sandro Anders | CarMedialab" <sandro.anders@carmedialab.com>
Subject: socket-can raw filter problem
Date: Fri, 31 May 2013 09:13:56 +0200
Message-ID: <18F8639CFC8C7C4D819AB347808079D401F0B47E@pluto.office.rac.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rac.de ([213.144.11.11]:57984 "EHLO mail.rac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab3EaHWV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 May 2013 03:22:21 -0400
Received: from pluto.office.rac.de (gate [213.144.11.9])
	by smtp.office.rac.de (Postfix) with ESMTP id 3618660655
	for <linux-can@vger.kernel.org>; Fri, 31 May 2013 09:13:57 +0200 (CEST)
Content-class: urn:content-classes:message
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

I've a problem with the raw filters in my application. If I set two
filters, and a received CAN message passes both, then my code receives
the message twice - see debug output below. 

I have a temporary work around but would like to know whether this is a
"feature" of Socket CAN or a bug.
0 code:7e8, mask:7ff  // first filter
1 code:7e8, mask:7e8  // second filter
Add message 7e0 1 7 0 to queue at time 171 types 0 1
tx id: 7e0 1 171 171 10 0 0 1    // send a 7E0 message
Data is available now.  // received response first time
Run: received 07e8 at time 7a735
Data is available now.  // received responce a second time

Thanks and best regards,
Sandro
