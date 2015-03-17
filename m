From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC] Join CAN filters with CAN_RAW_JOIN_FILTERS sockopt is ready
 for testing
Date: Tue, 17 Mar 2015 20:42:39 +0100
Message-ID: <550883AF.7080703@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:44580 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbCQTml (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 15:42:41 -0400
Received: from [192.168.1.194] (p5B0B0CB6.dip0.t-ipconnect.de [91.11.12.182])
	by smtp.strato.de (RZmta 37.4 DYNA|AUTH)
	with ESMTPSA id 6036b8r2HJgdtjK
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <linux-can@vger.kernel.org>;
	Tue, 17 Mar 2015 20:42:39 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi all,

as discussed today I posted the patches to "fix the long standing bug" of 
getting duplicate CAN frames when having overlapping filters.

The second patch (and the candump patch) is to test the functionality to 
implement joined filters which provides a logical AND for the given filters.

Happy testing - feedback is welcome!

Regards,
Oliver
