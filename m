From: Guillaume Picquet <guillaume@picquet.fr>
Subject: Setting bitrate from user-space application
Date: Wed, 25 Nov 2015 15:02:21 +0100
Message-ID: <5655BF6D.3000701@picquet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bounce-2.online.net ([62.210.16.44]:51205 "EHLO
	bounce-2.online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbbKYORq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2015 09:17:46 -0500
Received: from [62.210.16.40] (helo=smtpauth-dc2-1.online.net)
	by bounce-dc2-2.online.net with esmtpa (Exim 4.82)
	(envelope-from <guillaume@picquet.fr>)
	id 1a1aeQ-0006YT-LK
	for linux-can@vger.kernel.org; Wed, 25 Nov 2015 15:02:26 +0100
Received: from [78.224.49.244] (helo=[0.0.0.0])
	by smtpauth-dc2-1.online.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <guillaume@picquet.fr>)
	id 1a1aa2-00006b-QM
	for linux-can@vger.kernel.org; Wed, 25 Nov 2015 14:57:54 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

I prefer to ask first to those who know.

What is the 'normal' way of setting CAN bitrate from user-space 
application ?
Is there a library for that ?
If no shall I use netlink ?
if yes Can I use libnl ?

Thanks in advance for showing me where to dig internet.

regards.
