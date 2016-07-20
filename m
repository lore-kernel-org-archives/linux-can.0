From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Clear errorframe
Date: Wed, 20 Jul 2016 10:38:26 +0200
Message-ID: <578F3882.30803@grandegger.com>
References: <b91b00bc-8ebb-766b-5fc1-57e37886bc87@laure.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.151]:47810 "EHLO
	mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbcGTIif (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2016 04:38:35 -0400
In-Reply-To: <b91b00bc-8ebb-766b-5fc1-57e37886bc87@laure.nz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Laurenz <linux-can@laure.nz>, linux-can@vger.kernel.org

Hello,

Am 19.07.2016 um 16:12 schrieb Laurenz:
> Hi,
>
> when I "cansend can0 000#" and no device is attached to my bus, "candump
> -e any,#FFFFFFFF" will print a no-acknowledgement-on-tx errorframe forever.
>
> Is there a way to clear the error?

That is *normal* behaviour. It's the hardware retrying to send out the 
message. Is it necessary to send such an error message for each retry? 
Well, that's discussable. What CAN controller are you using?

Wolfgang.

