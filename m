From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: net: can: Convert M_CAN to
 json-schema
Date: Tue, 18 Feb 2020 15:11:38 -0600
Message-ID: <20200218211138.GA12217@bogus>
References: <20200207100306.20997-1-benjamin.gaignard@st.com>
 <20200207100306.20997-3-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35925 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgBRVLk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Feb 2020 16:11:40 -0500
Content-Disposition: inline
In-Reply-To: <20200207100306.20997-3-benjamin.gaignard@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, sriram.dash@samsung.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>

On Fri, 7 Feb 2020 11:03:06 +0100, Benjamin Gaignard wrote:
> Convert M_CAN bindings to json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 4:
> - remove useless ref to can-transceiver.yaml
> 
> version 3:
> - move can-transceive node into bosch,m_can.yaml bindings
>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 144 +++++++++++++++++++++
>  .../devicetree/bindings/net/can/m_can.txt          |  75 -----------
>  2 files changed, 144 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
> 

Applied, thanks.

Rob
