From: "Max S." <max@schneidersoft.net>
Subject: struct can_bittiming/struct can_berr_counter
Date: Sat, 12 Jan 2013 20:29:34 +0000
Message-ID: <1358022574.2504.23.camel@blackbox>
References: <1356821415.6901.159.camel@blackbox>
	 <50EB20C0.4000201@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:38237 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab3ALU1y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 12 Jan 2013 15:27:54 -0500
Received: from [192.168.1.54] (unknown [187.117.153.241])
	(Authenticated sender: max@schneidersoft.net)
	by mail.schneidersoft.net (Postfix) with ESMTPSA id 9DC651A12B
	for <linux-can@vger.kernel.org>; Sat, 12 Jan 2013 14:29:49 -0600 (CST)
In-Reply-To: <50EB20C0.4000201@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

Hello,

What is the reason why struct can_bittiming and struct can_berr_counter
use __u32 for all its members?

In the case of txerr and rxerr are those not even limited to 255 in the
CAN specification?

Max S.


