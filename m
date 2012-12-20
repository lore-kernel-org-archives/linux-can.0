From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Thu, 20 Dec 2012 13:20:53 +0100
Message-ID: <50D302A5.30706@grandegger.com>
References: <cover.1355996839.git.amit.virdi@st.com> <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com> <50D2E7DE.5030808@grandegger.com> <50D2EE10.6090208@st.com> <D5ECB3C7A6F99444980976A8C6D896384FB4C296A6@EAPEX1MAIL1.st.com> <50D2F29E.6010703@grandegger.com> <50D2F3F0.7040509@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40028 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab2LTMU5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 07:20:57 -0500
In-Reply-To: <50D2F3F0.7040509@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amit Virdi <amit.virdi@st.com>
Cc: Bhupesh SHARMA <bhupesh.sharma@st.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "anilkumar@ti.com" <anilkumar@ti.com>, spear-devel <spear-devel@list.st.com>

On 12/20/2012 12:18 PM, Amit Virdi wrote:
> On 12/20/2012 4:42 PM, Wolfgang Grandegger wrote:
>>> I believe this is a good feature to keep, otherwise we always have
>>> the default option of
>>> >  having equal msg objects for Tx and Rx purposes (16 each).
>> We need to improve the RX handling anyway similar to Marc's at91_can
>> driver. There 24 objects are used for RX and 8 for TX.
> 
> Ok but maybe for the time being we can go ahead with this
> implementation. When Marc's helper library is ready, we can send patches
> over the current implementation to adapt to it.

This TX handing improvement does not block this patch. The question is
also if the device-tree is the right place for such variables. If they
should be configurable by the user, the device-tree is too static (apart
from the fact that it's not a hardware property). A normal user cannot
change the device-tree.

Wolfgang.


