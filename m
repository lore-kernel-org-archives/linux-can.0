From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v3 1/2] can: m_can: add device tree binding
 documentation
Date: Mon, 14 Jul 2014 13:04:04 +0800
Message-ID: <20140714050403.GB1668@shlinux1.ap.freescale.net>
References: <1405074557-5519-1-git-send-email-b29396@freescale.com>
 <53BFBF3F.8040804@gmail.com>
 <20140714032451.GA1668@shlinux1.ap.freescale.net>
 <53C35E72.2050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dns-bn1lp0143.outbound.protection.outlook.com ([207.46.163.143]:47630
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750865AbaGNFIj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Jul 2014 01:08:39 -0400
Content-Disposition: inline
In-Reply-To: <53C35E72.2050902@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com

On Mon, Jul 14, 2014 at 10:07:06AM +0530, Varka Bhadram wrote:
> On 07/14/2014 08:54 AM, Dong Aisheng wrote:
> >On Fri, Jul 11, 2014 at 04:11:03PM +0530, Varka Bhadram wrote:
> >>On 07/11/2014 03:59 PM, Dong Aisheng wrote:
> >>>add M_CAN device tree binding documentation
> >>>
> >>>Cc: Wolfgang Grandegger <wg@grandegger.com>
> >>>Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> >>>Cc: Mark Rutland <mark.rutland@arm.com>
> >>>Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> >>>Cc: Varka Bhadram <varkabhadram@gmail.com>
> >>>Signed-off-by: Dong Aisheng <b29396@freescale.com>
> >>>---
> >>>  .../devicetree/bindings/net/can/m_can.txt          |   65 ++++++++++++++++++++
> >>>  1 files changed, 65 insertions(+), 0 deletions(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
> >>>
> >>>diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
> >>>new file mode 100644
> >>>index 0000000..c4cb263
> >>>--- /dev/null
> >>>+++ b/Documentation/devicetree/bindings/net/can/m_can.txt
> >>>@@ -0,0 +1,65 @@
> >>>+Bosch MCAN controller Device Tree Bindings
> >>>+-------------------------------------------------
> >>>+
> >>>+Required properties:
> >>>+- compatible		: Should be "bosch,m_can" for M_CAN controllers
> >>>+- reg			: physical base address and size of the M_CAN
> >>>+			  registers map and Message RAM
> >>>+- reg-names		: Should be "m_can" and "message_ram"
> >>>+- interrupts		: Should be the interrupt number of M_CAN interrupt
> >>>+			  line 0 and line 1, could be same if sharing
> >>>+			  the same interrupt.
> >>>+- interrupt-names	: Should contain "int0" and "int1"
> >>>+- clocks		: Clocks used by controller, should be host clock
> >>>+			  and CAN clock.
> >>>+- clock-names		: Should contain "hclk" and "cclk"
> >>>+- pinctrl-<n>		: Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
> >>I think this should be pinctrl-0
> >>
> >First, this part is defined by pinctrl binding doc.
> >Second i think it may be possible someone wants to add other pinctrl states
> >when implement low power state in the future.
> >So i just keep it as pinctrl-<n>.
> 
> Normally we will use pinctrl-0 for mentioning the pinctrl bindings.
> 
> If somebody going to add something to the pinctrl bindings they will
> add separately with pinctrl-1: bla bla bla...
> 

Will it cause misleading that it only supports one state?
And if we only define pinctrl-0 here, how do we describe pinctrl-names?
It should be "default"? It looks not accurate enough to me.

Per my understanding, I think it's better to leave it as standard
pinctrl-binding doc states since anyhow people should read pinctrl-binding doc.

> >>>+- pinctrl-names		: Names corresponding to the numbered pinctrl states
> >>remove 1 tab space before :
> >>
> >It's a bit strange.
> >Other line like pinctrl-<n> is also two tabs.
> >And the code looks fine and already aligned.
> >- pinctrl-<n>		: Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
> >- pinctrl-names		: Names corresponding to the numbered pinctrl states
> >Do you mean change line of pinctrl-names from two tabs to one space and a tab before :?
> >
> When i see in the patch the alignment is like this
> pinctrl-<n>	:
> pinctrl-name		:
> 

Yes,in the original patch it's like:
+- pinctrl-<n>          : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
+- pinctrl-names                : Names corresponding to the numbered pinctrl states

If remove one tab:
+- pinctrl-<n>          : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
+- pinctrl-names        : Names corresponding to the numbered pinctrl states

But in vim reading the code, it's like:
- pinctrl-<n>           : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
- pinctrl-names : Names corresponding to the numbered pinctrl states
I don't know why.
What should we do about this case?


> >>>+- mram-cfg		: Message RAM configuration data.
> >>>+  Multiple M_CAN instances can share the same Message RAM and each element(e.g
> >>>+  Rx FIFO or Tx Buffer and etc) number in Message RAM is also configurable,
> >>>+  so this property is telling driver how the shared or private Message RAM
> >>>+  are used by this M_CAN controller.
> >>>+
> >>It may written like:
> >>mram-cfg		: Message RAM configuration data
> >>			  Multiple M_CAN instances can share the same Message RAM and each element
> >>			  (e.g Rx FIFO or Tx Buffer and etc) number in Message RAM is also configurable,
> >>			  ...
> >>
> >I'm fine with that.
> >The question is it's easy to over 80 columns if writing like that,
> >is it ok?
> 
> When we follow the above format it would be more readable.
> 

Okay.

> >Regards
> >Dong Aisheng
> 
> 
> -- 
> Regards,
> Varka Bhadram.
>

Regards
Dong Aisheng

 
