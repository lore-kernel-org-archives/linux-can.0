From: "Boris Baskevitch" <boris.baskevitch@annecy-elec.fr>
Subject: CAN-BCM periodic send signaling
Date: Mon, 6 Jan 2014 18:11:23 +0100
Message-ID: <003601cf0b02$53c58f10$fb50ad30$@annecy-elec.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from riga.magic.fr ([188.130.33.24]:49389 "HELO riga.magic.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754093AbaAFRSH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Jan 2014 12:18:07 -0500
Content-Language: fr
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,
Happy new year everybody !
I'm using the CAN-BCM to send periodic CAN messages on the bus.
In one of those messages, I need to send a counter value which is incremented each time the message is sent.
How can I do that ? Is there a call-back that I could setup to increment my counter each time the BCM is sending my message ?

Thanks for your help !

Boris


