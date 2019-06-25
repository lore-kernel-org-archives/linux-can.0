From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v12 5/5] can: m_can: Fix checkpatch issues on existing
 code
Date: Tue, 25 Jun 2019 14:54:53 +0530
Message-ID: <f7f61ccb-f6e9-1e74-a716-96f246944b64@ti.com>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-5-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509161109.10499-5-dmurphy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi,

On 09/05/19 9:41 PM, Dan Murphy wrote:
> Fix checkpatch issues found during the m_can framework creation.
> The code the issues were in, was in untouched code and these
> changes should be done separately as to not be confused with the
> framework changes.
> 
> Fix these 3 check issues:
> CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_ERROR_WARNING'
> 	if (psr & PSR_EW &&
> 	    (cdev->can.state != CAN_STATE_ERROR_WARNING)) {
> 
> CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_ERROR_PASSIVE'
> 	if ((psr & PSR_EP) &&
> 	    (cdev->can.state != CAN_STATE_ERROR_PASSIVE)) {
> 
> CHECK: Unnecessary parentheses around 'cdev->can.state != CAN_STATE_BUS_OFF'
> 	if ((psr & PSR_BO) &&
> 	    (cdev->can.state != CAN_STATE_BUS_OFF)) {
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Acked-by: Faiz Abbas <faiz_abbas@ti.com>

Thanks,
Faiz
