From: Amit Virdi <amit.virdi@st.com>
Subject: Re: [PATCH 1/3] can: c_can: Correct register alignment info passing
 through DT
Date: Wed, 16 Jan 2013 13:10:55 +0530
Message-ID: <50F65987.40903@st.com>
References: <cover.1355996839.git.amit.virdi@st.com> <4fb69be55045aa390e73c56b215a4b4afb091d1a.1355996839.git.amit.virdi@st.com> <50D319D6.1060201@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:47084 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758088Ab3APHlJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Jan 2013 02:41:09 -0500
In-Reply-To: <50D319D6.1060201@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "anilkumar@ti.com" <anilkumar@ti.com>, spear-devel <spear-devel@list.st.com>

On 12/20/2012 7:29 PM, Marc Kleine-Budde wrote:
> On 12/20/2012 11:05 AM, Amit Virdi wrote:
>> Depending upon the integration of the C_CAN controller in the SoC, the
>> registers may be aligned to 16-bit or 32-bit boundary. The device tree
>> support added to the driver assumes this information can be passed
>> through 'flags' in the platform resources, however current DT
>> implementation provides no such provision.
>>
>> So passing the information explicitly through the optional parameter
>> 'reg_alignment' in the device tree.
>
> Please put devicetree-discuss for dt related topics on Cc. Have a look
> at Documentation/devicetree/bindings for existing bindings. E.g. there
> already is reg-io-width.
>

Yeah, thanks! I would modify the code for this.

Regards
Amit Virdi
