From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: What are you doing if the TX buffer overflows?
Date: Mon, 17 Sep 2012 13:58:30 +0000
Message-ID: <2478881.znSzbTXnK5@uschi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from host24.networkinvest.de ([46.4.85.104]:56024 "EHLO
	host24.networkinvest.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332Ab2IQOID convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Sep 2012 10:08:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by host24.networkinvest.de (Postfix) with ESMTP id 600DF3F3213F
	for <linux-can@vger.kernel.org>; Mon, 17 Sep 2012 15:58:32 +0200 (CEST)
Received: from host24.networkinvest.de ([127.0.0.1])
	by localhost (host24.networkinvest.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZAjo-vhMak3Y for <linux-can@vger.kernel.org>;
	Mon, 17 Sep 2012 15:58:32 +0200 (CEST)
Received: from remote.port.de (business-178-015-016-250.static.arcor-ip.net [178.15.16.250])
	(Authenticated sender: web12p1)
	by host24.networkinvest.de (Postfix) with ESMTPSA id 422873F3212B
	for <linux-can@vger.kernel.org>; Mon, 17 Sep 2012 15:58:32 +0200 (CEST)
Content-Language: de-DE
Content-ID: <5DCE4B9759AED64C9DD5AB419A491A5D@portgmbh.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


Hello,
is there a way to empty the tx buffer ?
Or read out the occupied size of it
to get the mumber of CAN frames waiting for transmission?

Best regards
 Heinz-J=FCrgen Oertel