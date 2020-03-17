From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 04/12] docs: dt: fix references to m_can.txt file
Date: Tue, 17 Mar 2020 08:29:45 -0500
Message-ID: <60f77c6f-0536-1f50-1b49-2f604026a5cb@ti.com>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <db67f9bc93f062179942f1e095a46b572a442b76.1584450500.git.mchehab+huawei@kernel.org>
 <376dba43-84cc-6bf9-6c69-270c689caf37@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <376dba43-84cc-6bf9-6c69-270c689caf37@pengutronix.de>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello

On 3/17/20 8:17 AM, Marc Kleine-Budde wrote:
> On 3/17/20 2:10 PM, Mauro Carvalho Chehab wrote:
>> This file was converted to json and renamed. Update its
>> references accordingly.
>>
>> Fixes: 824674b59f72 ("dt-bindings: net: can: Convert M_CAN to json-schema")

I am trying to find out where the above commit was applied

I don't see it in can-next or linux-can. I need to update the tcan dt 
binding file as it was missed.

And I am not sure why the maintainers of these files were not CC'd on 
the conversion of this binding.

Dan
