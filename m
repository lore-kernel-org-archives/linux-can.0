From: Sven Geggus <lists@fuchsschwanzdomain.de>
Subject: ODB-II Interfaces and Linux CAN?
Date: Fri, 27 Apr 2012 09:46:20 +0000 (UTC)
Message-ID: <jndptc$9c5$1@ultimate100.geggus.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.gnuher.de ([78.47.12.54]:45338 "EHLO mail.gnuher.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759151Ab2D0Jq1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 27 Apr 2012 05:46:27 -0400
Received: from ultimate100.geggus.net ([2a01:198:297:1::1])
	by mail.gnuher.de (envelope-from
	<news@geggus.net>)
	with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	id 1SNhkr-0001JD-2l
	for linux-can@vger.kernel.org; Fri, 27 Apr 2012 11:46:21 +0200
Received: from news  by ultimate100.geggus.net (envelope-from
	<news@geggus.net>)
	with local (Exim 4.72)
	id 1SNhkq-0002Yr-FY
	for linux-can@vger.kernel.org; Fri, 27 Apr 2012 11:46:20 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

cheap ODB-II Interfaces claiming to support CAN (at least up to 500 kbps)
are available for less than 20 Euros now.

Here is one of them:
http://www.autodia.de/produkte/autodia-e327/technische-daten

Will this already work with socketcan or would it be possible to implement
support?

Sven

-- 
"If you don't make lower-resolution mapping data publicly
available, there will be people with their cars and GPS
devices, driving around with their laptops" (Tim Berners-Lee)
/me is giggls@ircnet, http://sven.gegg.us/ on the Web
