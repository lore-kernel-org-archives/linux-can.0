From: "Max S." <max@schneidersoft.net>
Subject: Re: GS_USB
Date: Mon, 07 Oct 2013 19:52:26 +0000
Message-ID: <1381175546.21207.37.camel@blackbox>
References: <1380889887.22484.2.camel@blackbox>
	 <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>
	 <5e3f6029b128db63c69664deed10c5d6@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:50236 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab3JGTlF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 15:41:05 -0400
In-Reply-To: <5e3f6029b128db63c69664deed10c5d6@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can <linux-can@vger.kernel.org>

On Mon, 2013-10-07 at 16:37 +0200, Wolfgang Grandegger wrote:
> Will not find time for the review today...

no problem.

> The CAN controller does not do any asynchronous error reporting,
> right? This will limit the usability of this device, especially
> CAN applications relying on that feature will not work. Any chance
> to add asynchronous error reporting to the firmware?

Only CAN_ERR_CRTL_RX_OVERFLOW is currently reported (possible when host
is too slow).
CAN_ERR_CRTL_TX_OVERFLOW is impossible due to the driver design
(tx context + echo).

Which errors are most important to the applications you mentioned?

The hardware does not allow for the sensing of the CAN_ERR_TRX_* errors.
I can sense some  CAN_ERR_PROT_* errors, as well as all CAN_ERR_CRTL_*
errors.

In firmware it is possible to queue error/status frames much like normal
frames. So they would show up in the receive callback... Thats what you
meant by asynchronous right?

regards,
Max Schneider.

