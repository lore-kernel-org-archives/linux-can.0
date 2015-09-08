From: Daniel Squires <dan@engineeredarts.co.uk>
Subject: socket can receive order
Date: Tue, 08 Sep 2015 10:42:37 +0100
Message-ID: <55EEAD8D.3070603@engineeredarts.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from engineeredarts.co.uk ([162.13.42.246]:58114 "EHLO
	mail.engineeredarts.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbIHJth (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 05:49:37 -0400
Received: from [10.11.12.114] (cpc4-hitc7-2-0-cust1836.9-2.cable.virginm.net [81.107.111.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: dan)
	by mail.engineeredarts.co.uk (Postfix) with ESMTPSA id EFAC888BEC
	for <linux-can@vger.kernel.org>; Tue,  8 Sep 2015 09:44:28 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

new to this list.

Just a quick question at present, when using recv on a socket that is 
bound to a can interface, should the packets be received in the order 
they came off the wire? or is this not guaranteed?

for example, is this valid or an error in some part of the system?

candump can3 -tz
<snip>
  (003.088648)  can3  043   [8]  F7 2D 00 00 00 00 00 00
  (003.089149)  can3  045   [8]  F9 2D 00 00 00 00 00 00
  (003.088897)  can3  044   [8]  F8 2D 00 00 00 00 00 00

The packets were sent to the wire in order, the CAN ID is incremented 
with each send to ensure mailbox/arbitration details dont mess up the 
order on to the wire, the packets were seen coming off the wire over USB 
in wireshark in the correct order, but my test utility which aborts when 
something unexpected happens and candump both see this out of sequence 
result. Note that  the timestamps confirm that something saw them in the 
correct order, but recv returns them out of order.

Another identical receiver with another instance of candump sees the 
packets in the expected order, but sees other packets at other times out 
of order, i.e. it appears random.

Thanks

-- 
Dan Squires

Engineered Arts Ltd.

