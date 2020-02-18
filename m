From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindinsg: net: can: Convert can-transceiver to
 json-schema
Date: Tue, 18 Feb 2020 15:11:23 -0600
Message-ID: <20200218211123.GA11668@bogus>
References: <20200207100306.20997-1-benjamin.gaignard@st.com>
 <20200207100306.20997-2-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200207100306.20997-2-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, sriram.dash@samsung.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-can.vger.kernel.org

On Fri, 7 Feb 2020 11:03:05 +0100, Benjamin Gaignard wrote:
> Convert can-transceiver property to json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 4:
> - no change
> 
> version 3:
> - only declare max-bitrate property in can-transceiver.yaml
> 
>  .../bindings/net/can/can-transceiver.txt           | 24 ----------------------
>  .../bindings/net/can/can-transceiver.yaml          | 18 ++++++++++++++++
>  2 files changed, 18 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
>  create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.yaml
> 

Applied, thanks.

Rob
