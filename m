From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Fri, 23 Mar 2012 12:01:01 +0100
Message-ID: <4F6C57ED.8020304@grandegger.com>
References: <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <4F69D5D2.5080003@hartkopp.net> <20120321135339.GB6428@vandijck-laurijssen.be> <4F69EC19.7090205@grandegger.com> <4F69EE38.9000904@hartkopp.net> <20120322092456.GB426@vandijck-laurijssen.be> <4F6AF320.7080605@grandegger.com> <20120322101311.GD426@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:42807 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab2CWLBO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Mar 2012 07:01:14 -0400
In-Reply-To: <20120322101311.GD426@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

On 03/22/2012 11:13 AM, Kurt Van Dijck wrote:
> On Thu, Mar 22, 2012 at 10:38:40AM +0100, Wolfgang Grandegger wrote:
>> On 03/22/2012 10:24 AM, Kurt Van Dijck wrote:
>>> On Wed, Mar 21, 2012 at 04:05:28PM +0100, Oliver Hartkopp wrote:
>>>> On 21.03.2012 15:56, Wolfgang Grandegger wrote:
>>>>
>>
>>>>>>> 3. Will these differences be visible in the CAN registers? Is this relevant?
>>>>>> Without hardware, it's a bit early to predict. I guess it will be visible, but
>>>>>> not relevant since that's driver stuff.
>>>>>
>>>>> As CANFD controllers also supports CAN2.0 frames, they must provide the
>>>>> the relevant information somehow, similar to EFF and SFF.
>>> I doubt this.
>>> EFF & SFF share the same bus. CANFD vs. CAN2.0 is not a per-frame thing. You
>>> have configured it yourself at chip initialization time...
>>
>> Why not? A CANFD capable controller should be able to distinguish
>> between a legacy and a CANFD frame by looking to the BRS bit in the frame.
> Good point!

I got some more infos about the up-coming CAN FD controllers:

- There will be two sets of bit-timing configuration registers.

- They will have configuration bits to disable the FD functions. Then
  they will behave just like legacy CAN controllers. This can only be
  configured before going "bus on" ("clear init").

- When the FD function is enabled, *both* legacy CAN and FD frames
  will be accepted. The *TX* FD function must be enabled separately,
  otherwise legacy CAN frames will be sent. This can be changed while
  running (bus-on).

- This means, on a bus with only CAN FD controllers, both, legacy and FD
  frames can be sent and received. Not sure if that makes sense, though.

- The CAN FD format (DLC up to 64 bytes) and the bit-rate switching can
  be enabled *individually*.

- Per message, there will be three additional bits in the control field:

  - EDL bit: shows if the message is in the CAN FD format.
  - BRS bit: shows if the bit-rate was switched.
  - ESI bit: shows if the sender of the CAN FD-Frames was in error-
             active or error-passive state.

- The bits above need not be set for sending CAN FD frames as they are
  already defined by the selected TX FD modes.

- If EDL=1, DLC has a different meaning.

- RTR frames will always be send in the legacy format.

- Furthermore, there might also be cost-efficient CAN FD controller
  chips which only support 8 bytes per frame (instead of 64). The
  software needs to be aware of that.

See also:

- http://www.can-cia.org/fileadmin/cia/files/icc/13/hartwich.pdf
- http://www.can-cia.org/fileadmin/cia/files/icc/13/oertel.pdf

I think this makes a bit more clear what needs to be done to support CAN
FD on the protocol and driver level. My feeling is still that we should
add a new "struct canfd_frame", which the apps then can specify with
send and recv calls maintaining full backward with "struct can_frame".
For the RX path, skbs for either "canfd_frame" or "can_frame" shall be
allocated depending on the EDL bit (or DLC). We may also want to have an
interface for dynamic bit-rate switching.

Wolfgang.

