From: Laurenz <linux-can@laure.nz>
Subject: Re: Clear errorframe
Date: Wed, 20 Jul 2016 10:49:36 +0200
Message-ID: <480d654d-1efd-fd5c-d091-cc766a7ddb7f@laure.nz>
References: <b91b00bc-8ebb-766b-5fc1-57e37886bc87@laure.nz>
 <578F3882.30803@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gacrux.uberspace.de ([185.26.156.53]:35593 "EHLO
	gacrux.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbcGTItl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2016 04:49:41 -0400
In-Reply-To: <578F3882.30803@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

Hi Wolfgang,

> What CAN controller are you using?
This was an Ixxat USB-to-CAN V2.

I tested with an PCAN-USB and it sends one 
controller-problem{rx-error-warning,tx-error-warning} followed by one 
controller-problem{rx-error-passive,tx-error-passive} in the same test.

So I can just ignore the repeated error? I will write to Ixxat support, 
maybe they can change it.

Thanks
Laurenz
