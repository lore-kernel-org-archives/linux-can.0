From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Clear errorframe
Date: Wed, 20 Jul 2016 14:27:26 +0200
Message-ID: <578F6E2E.6090101@grandegger.com>
References: <b91b00bc-8ebb-766b-5fc1-57e37886bc87@laure.nz>
 <578F3882.30803@grandegger.com>
 <480d654d-1efd-fd5c-d091-cc766a7ddb7f@laure.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.151]:55106 "EHLO
	mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbcGTM1b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2016 08:27:31 -0400
In-Reply-To: <480d654d-1efd-fd5c-d091-cc766a7ddb7f@laure.nz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Laurenz <linux-can@laure.nz>, linux-can@vger.kernel.org

Hello Laurenz,

Am 20.07.2016 um 10:49 schrieb Laurenz:
> Hi Wolfgang,
>
>> What CAN controller are you using?
> This was an Ixxat USB-to-CAN V2.
>
> I tested with an PCAN-USB and it sends one
> controller-problem{rx-error-warning,tx-error-warning} followed by one
> controller-problem{rx-error-passive,tx-error-passive} in the same test.

The exact message depends on the CAN controller.

> So I can just ignore the repeated error? I will write to Ixxat support,
> maybe they can change it.

Yes, you could change your error message mask in case you are not 
interested in such messages.

In general, it might be a better policy to treat such errors like bus 
errors allowing to enabled them on demand.

Wolfgang.

