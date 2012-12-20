From: Bhupesh SHARMA <bhupesh.sharma@st.com>
Subject: RE: [PATCH 2/3] can: c_can: Provide generic interface to configure
 c-can message objects
Date: Thu, 20 Dec 2012 19:06:06 +0800
Message-ID: <D5ECB3C7A6F99444980976A8C6D896384FB4C296A6@EAPEX1MAIL1.st.com>
References: <cover.1355996839.git.amit.virdi@st.com>
 <cf2aa76940e89dc91564cf4962d23e58bec432b0.1355996839.git.amit.virdi@st.com>
 <50D2E7DE.5030808@grandegger.com> <50D2EE10.6090208@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:44496 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809Ab2LTLGg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 20 Dec 2012 06:06:36 -0500
In-Reply-To: <50D2EE10.6090208@st.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amit VIRDI <Amit.VIRDI@st.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "anilkumar@ti.com" <anilkumar@ti.com>, spear-devel <spear-devel@list.st.com>

> On 12/20/2012 3:56 PM, Wolfgang Grandegger wrote:
> > On 12/20/2012 11:05 AM, Amit Virdi wrote:
> >> Depending on the underlying platform, the configuration of the c-can
> >> message objects can change. For e.g. in some systems, it makes more
> >> sense to receive many message objects and transmit very few. In any
> >> case, providing flexibility in configuring the message objects is
> >> highly desirable.
> >>
> >> The total number of message objects for C_CAN controller is fixed at 32.
> >> The receive message objects are assigned higher priority so they
> >> begin with message object#1. So, in order to configure the message
> >> object the driver just needs two parameters - rx_split (for
> >> differentiating between lower bucket and higher bucket) and tx_num.
> >
> > What is your motivation to make this configurable?
> > Why is the current default not good enough?
> 
> By default the number of receive message objects is kept equal to the
> number of transmit message objects (16). However, we had some practical
> use cases in which it was expected that the controller would receive more
> number of message objects than it would transmit. The current configuration
> didn't result in an efficient behavior. Maybe, Bhupesh can elaborate this
> point in more detail.
> 

Yes. We actually had this requirement from one of our customer whose use-case involved
the SPEAr MPU to be a master controlling a processing line having a number of CAN devices. In such a case
there was a specific requirement to have more Rx objects than Tx ones.

I believe this is a good feature to keep, otherwise we always have the default option of 
having equal msg objects for Tx and Rx purposes (16 each).

Regards,
Bhupesh
