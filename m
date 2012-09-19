From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Wed, 19 Sep 2012 07:56:35 +0200
Message-ID: <50595E93.2030307@gaisler.com>
References: <5058994E.8000501@gaisler.com> <1347986041-5358-1-git-send-email-andreas@gaisler.com> <5058BCFB.7010902@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:23632 "HELO
	vsp-authed-01-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754086Ab2ISF5J (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 01:57:09 -0400
In-Reply-To: <5058BCFB.7010902@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

On 09/18/2012 08:27 PM, Wolfgang Grandegger wrote:
> On 09/18/2012 06:34 PM, Andreas Larsson wrote:
>> One-shot mode correctly refrains from trying to resend frames that
>> fail. However, all can frames are echoed back by can_get_echo_skb
>> regardless of whether they were transmitted successfully or not. When
>> in one-shot mode, sja1000 generates a transmit interrupt both for a
>> successful and a failed transmission. It is not possible to
>> distinguish between the cases and therefore not possible to refrain
>> from echoing back a frame that was not transmitted successfully.
>
> Did you check the transmission complete status bit (SR_TCS)? From the
> data sheet it's not 100% clear if it should work with single-shot
> messages as well.

Ah, excellent! This indeed indicates correctly in one-shot mode whether 
a message has been transmitted successfully or not. Thanks!

Cheers,
Andreas

