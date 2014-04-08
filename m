From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2] =?UTF-8?Q?c=5Fcan=3A=20Add=20support=20for=20eg=32?=  =?UTF-8?Q?=30t=20=28pch=5Fcan=29?=
Date: Tue, 08 Apr 2014 14:26:46 +0000
Message-ID: <090fcf0570603b5f43a7d2863a5b46c4@grandegger.com>
References: <"<533DB663.3030408@hartkopp.net>">
 <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com>
 <alpine.DEB.2.02.1404081619590.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:48713 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128AbaDHO0s (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 8 Apr 2014 10:26:48 -0400
In-Reply-To: <alpine.DEB.2.02.1404081619590.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, 8 Apr 2014 16:20:41 +0200 (CEST), Thomas Gleixner
<tglx@linutronix.de> wrote:
> On Mon, 7 Apr 2014, Alexander Stein wrote:
>> -	addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
>> +	addr = pci_iomap(pdev, c_can_pci_data->bar, pci_resource_len(pdev,
0));
> 
> Shouldn't that be pci_resource_len(pdev, bar) ????

Yes, or just "0".

Wolfgang.

