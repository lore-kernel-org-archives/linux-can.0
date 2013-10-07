From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: GS_USB
Date: Mon, 07 Oct 2013 22:30:30 +0200
Message-ID: <525319E6.4020505@grandegger.com>
References: <1380889887.22484.2.camel@blackbox>	 <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>	 <5e3f6029b128db63c69664deed10c5d6@grandegger.com> <1381175546.21207.37.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35103 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab3JGUbJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 16:31:09 -0400
In-Reply-To: <1381175546.21207.37.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

On 10/07/2013 09:52 PM, Max S. wrote:
> On Mon, 2013-10-07 at 16:37 +0200, Wolfgang Grandegger wrote:
>> Will not find time for the review today...
> 
> no problem.
> 
>> The CAN controller does not do any asynchronous error reporting,
>> right? This will limit the usability of this device, especially
>> CAN applications relying on that feature will not work. Any chance
>> to add asynchronous error reporting to the firmware?
> 
> Only CAN_ERR_CRTL_RX_OVERFLOW is currently reported (possible when host
> is too slow).
> CAN_ERR_CRTL_TX_OVERFLOW is impossible due to the driver design
> (tx context + echo).
> 
> Which errors are most important to the applications you mentioned?

CAN error state changes are sufficient, including bus-off. Bus-off
recovery initiated by the software would be nice as well. Reporting
individual bus errors is less important.

> The hardware does not allow for the sensing of the CAN_ERR_TRX_* errors.
> I can sense some  CAN_ERR_PROT_* errors, as well as all CAN_ERR_CRTL_*
> errors.

> In firmware it is possible to queue error/status frames much like normal
> frames. So they would show up in the receive callback... Thats what you
> meant by asynchronous right?

Yep, an application can then read and handle these error messages. Here
is the output of "candump -candump -td -e any,0:0,#FFFFFFFF" showing
error state changes until bus-off and recovery with an SJA1000:

 (000.202225)  can0   5F  [8] 07 B4 4F 67 3A 90 D9 E4
 (000.201285)  can0  20000204  [8] 00 08 00 00 00 00 78 00   ERRORFRAME
        controller-problem{tx-error-warning}
        error-counter-tx-rx{{120}{0}}
 (000.003249)  can0  20000240  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
        bus-off
 (005.015531)  can0  20000100  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
        restarted-after-bus-off
        error-counter-tx-rx{{127}{0}}

We don't have yet support for decreasing the error state, e.g.:

 (000.000133)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
        state-change{back-to-error-active}


Wolfgang.
