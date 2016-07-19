From: Laurenz <linux-can@laure.nz>
Subject: Clear errorframe
Date: Tue, 19 Jul 2016 16:12:50 +0200
Message-ID: <b91b00bc-8ebb-766b-5fc1-57e37886bc87@laure.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gacrux.uberspace.de ([185.26.156.53]:59375 "EHLO
	gacrux.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbcGSOTi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2016 10:19:38 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

when I "cansend can0 000#" and no device is attached to my bus, "candump 
-e any,#FFFFFFFF" will print a no-acknowledgement-on-tx errorframe forever.

Is there a way to clear the error?

Cheers
Laurenz

