From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [info] Kconfig SELECT statement rules - was: FIXED_PHY is broken...
Date: Tue, 16 Dec 2014 17:36:45 +0100
Message-ID: <54905F9D.2090208@hartkopp.net>
References: <20141216.112534.1684849738404064350.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:36460 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbaLPQgt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Dec 2014 11:36:49 -0500
Received: from [192.168.178.68] (p5B0B2832.dip0.t-ipconnect.de [91.11.40.50])
	by smtp.strato.de (RZmta 36.3 DYNA|AUTH)
	with ESMTPSA id 606ba9qBGGajuWe
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <linux-can@vger.kernel.org>;
	Tue, 16 Dec 2014 17:36:45 +0100 (CET)
In-Reply-To: <20141216.112534.1684849738404064350.davem@davemloft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Just a hint from Dave when the SELECT statement is not appropriate when 
creating Kconfig files ... ;-)

Regards,
Oliver


-------- Forwarded Message --------
Subject: FIXED_PHY is broken...
Date: Tue, 16 Dec 2014 11:25:34 -0500 (EST)
From: David Miller <davem@davemloft.net>
To: netdev@vger.kernel.org
CC: f.fainelli@gmail.com


I get this now when I run oldconfig:

warning: (NET_DSA_BCM_SF2 && BCMGENET && SYSTEMPORT) selects FIXED_PHY which 
has unmet direct dependencies (NETDEVICES && PHYLIB=y)

For the thousandth time, you cannot select Kconfig options which have
dependencies of any kind, because select does not recursively cause
dependencies to be enabled up to the root of the Kconfig tree.

If you select on something which has a "depends on", stop right there
because you can't do it.

It only works for pure leaf Kconfig nodes with no deps.

All you needed to do in order to test this was do an allmodconfig
build.

--
To unsubscribe from this list: send the line "unsubscribe netdev" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


