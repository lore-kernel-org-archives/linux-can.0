Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20149431A5C
	for <linux-can@vger.kernel.org>; Thu,  1 Oct 2026 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790834923; cv=none; b=sVfpPWraD33WMDIlT6wI6Qy1LoyqzQHQWXU8d29iv+J8ocK0Yyv/UJ0WPfriemCVcuw5gH0Fa/BK5p62N3VgN+PYbhfZ2hm6uPooP1pXu5wRdKvAxAI9Xvo8HJbpwUmmlTu+HiuXnrFTEJh4lWhJoCxwNvhmwrktiUX4PaG8Q78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790834923; c=relaxed/simple;
	bh=EKISGBUUfR2T00G1oUFO8B5JWeNXQjqvDxFBm53oB1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bG4vSo9GaSZNHOckKz5SNMGELF+s/4Yxks6EjmJVS+gBghisFF6EBOWPR2NEi1k/8owPETlsFNiVyGlrDlBHIRX5E4lnaqCcKTeG27FGY9hYspRYGPRV07Fgo5JTvPimj7iVXQqMUtlSUIbBHiR41RluPWpCLe0c5ZD74BgNmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aAZb5a2W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eX2EvcA6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aAZb5a2W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eX2EvcA6"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6913fxfe1238051
	for <linux-can@vger.kernel.org>; Thu, 1 Oct 2026 06:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=30Jdl6JqUqExlNbkYRrVWI3IXB2MAdHLsLJ
	yVQztsQ4=; b=aAZb5a2WT1ujq3/UmHCBkODWRjIvyLCNAPmAknyQ1PEKTkj2nze
	bFrNNSGpXyIBY9VgaKUtWTksLF+dT7JywDE5FCeb0lvS05Q3TVtH76//nDFuOtVE
	psOUhIcULvKDTjAoPqdmBSauP+Jfi6Rz2cY/DYqVly4yycL6g16JBPislVs3Qn77
	7RCluYFx+uz48K92ca6SZaryHwhzEtU1qZHj3LoVBRslAVJqr2rIv0CNaCod/ivc
	il1LCKk+4L8B1/ZjI6NjjfsRGJYwb6ucCJzU3tjpEenBP7Ec5EmwQXuVayDWb4Y4
	B8zKZVN+AKNH6thN9psCN1fog7kwNbUxmhw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pjspv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 01 Oct 2026 06:08:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a082c014aso144775785a.0
        for <linux-can@vger.kernel.org>; Wed, 30 Sep 2026 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790834917; x=1791439717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=30Jdl6JqUqExlNbkYRrVWI3IXB2MAdHLsLJyVQztsQ4=;
        b=eX2EvcA6fDoDgqVXHGlrM+Jh6P0aEeIOHjniJmuv/I0gHPAsVmgWInt1Nu/BEmn1ub
         L9UPHZRv3nCm4RM2QhewUsZLBU9yLXXumO3p+irdFlmv4C6SYDtR6MQCgH2KTGJFBBea
         YS70v5nVMMnvLPxm3uWKQOEX+MMfemaL8HoeLyPoBFo4f+b/EDNHo8xNUOgyHNavPj7O
         3PleGRIfdFfbDR/ePqjGqOpG9zrjHuiKjqdzUWJiCjAHCvLfyVqz6S4ha4kG7/k7vtRf
         oQbKeT/ze0IfnQLukdqA9UbR7IP1Xdh6VrRKnq89vlWYH2LV4FRzh5iCBDbtgl1D6Go5
         70Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790834917; x=1791439717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=30Jdl6JqUqExlNbkYRrVWI3IXB2MAdHLsLJyVQztsQ4=;
        b=FmYVse8b6A4ewQefgKZ8lI6Wdm6rjgzKzfKlsGL64wtrVvl9OsUOgLKZfXnbAIJ4+2
         y0wBYlt7Vqg1JFBm4yl1uNrjc2jc4kqR9g3DzERPTSlr96757rcs+miHXdIH4XiQZat3
         N9tW+Su/yftnlQU9lj1BC8jw+WasJHjq1PoIiKexrWzu11QTauOqGbs16To5UZu1dtaP
         YrQyL6e0+lYUJpbPVfGeP3DH9Rd5wn8jb1+SEauN921GeCcToZdPnwvDkGh6YEx820Td
         fwSwC9RdM7iMiwbqeUaZufNJxfA9WZf7zMN3soIm1K/RAgCa4Gia+iTbMADYaGhKENMW
         NCjg==
X-Forwarded-Encrypted: i=1; AKwUvByGeZprDF6EuytAepn7YAjHj9tsdcvbZwVGrF0yMdckwlwyjPYtwhNom0q5pdsrhsKZfq6JGLatbhM=@vger.kernel.org
X-Gm-Message-State: AFuF++nhgvcy4N+arw++N2/Qg5N8/F3B+mcMLGBkArCEkyEseDV7jVal
	/tr/XUkWBKMmRa7qrMqC6zpjwiYZoDoEZ9z7Cea3kxcGgkrpomB1lxX9syQ2+ssAssuoTSZJpLb
	5tQdiTacvXo9Kza8qSg1yMCmrvQ82Jv2k1m9T6g/K5PgKmiwUh2ag1RuJE5T8Jqc=
X-Gm-Gg: AYBFou1dBgR6j1wC5RTRVPnSvyyvetWhEUkoSFW11I8CVK0PdM+TWfSHk+gd/Da6/g/
	702njO+FO6kh/7oqqcEOEmhyX+SjBQHZAwwrMndblCN/MLb4zWCY5TxRPf0MX5D1qz9Syv3sgwA
	1OLNgMGO5f01o6dhyh1I0n9KvHtZAGtdwvYWWx0zIFWNQfOUweNIhkwBYrUvl4a3w3/oj1gGPT4
	tRAl2dTJz4LW/Hu39M3f/6pTvUjHyB6MOFnaKtc0zA3piKn+XchuMxWN9ZtPH8dSVQNmqcNVCJ6
	G66/Sk3aTGVaiRdZ62o/vkfFldt+H5s0EsJLneB4qRtJgHHpDgclxfuvOs+NN9+n9vTs1kMBTqc
	zLtm898X0ZYMTIJg=
X-Received: by 2002:a05:620a:470a:b0:939:5d22:d1f0 with SMTP id af79cd13be357-93cb56464e5mr384548985a.2.1790834916894;
        Wed, 30 Sep 2026 23:08:36 -0700 (PDT)
X-Received: by 2002:a05:620a:470a:b0:939:5d22:d1f0 with SMTP id af79cd13be357-93cb56464e5mr384545085a.2.1790834916367;
        Wed, 30 Sep 2026 23:08:36 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a022619b42sm6316525e9.3.2026.09.30.23.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:08:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level
Date: Thu,  1 Oct 2026 08:08:26 +0200
Message-ID: <20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=EKISGBUUfR2T00G1oUFO8B5JWeNXQjqvDxFBm53oB1E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqvfjZPEQDW0HRJhcKDjtn+70niEdskRCFnDkWq
 fa0vMc6loWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCar342QAKCRDBN2bmhouD
 15s2D/9VCFFdVrnKQhXM+zRwcwvmq5yxk0g9DbBg/mEg+4hgMmCb9rYnxbdldXBshulD5bvnpN3
 tfyq9nZDuYawCej166ua9X2diCl1uI2AZHGh+jTFWLcd5iFYI1OTM5hvaU7TxqFSdvGX1y9B/kF
 nvCJDCC+qTVTZOxelHp5EoA93XyGOI3RdlHiB8RmgwKcBbu2R5fn3Pn0bG3sxsbf006oKHMVclt
 G9LMDOFrNuPn21v6f1hcJYQ/BtN43dxIwuyX2AM4725YGIeFDkILd1bZiMrwX5hMrXjQsl2DJi8
 Iu9uegAKjtWNnTC4uiPVA8PyvJGt08LgjJS5WQEd02VvV6GhlvsQkSw1ExO+goD29Fa/0VFJpAo
 x6QQL/pjAa8mji21Vyr0WEyv2EiYtOW4Ah76NLWK/B/gzdyovJNvjMe1ZbXhRsTktgXHlGCs+Bu
 RMbyfdY9SAV09YyrkgjSWwMmv/SjO3YsbBlUeRiIBNdpg9vwE6D25Er1Kn2ovjWidAHKy9HmMd5
 ODpSdPcDJgK1L/UddA0gFhW4sFiUz4KlJ9HtqS2W1UTj+CZQu8hLeJEvkSTVfz9zTXZT7OUZL+S
 oLDjVxkIN2O+m0CQ0ucOHzz1XTSU8KwHTtQi/HUa7HYFwUbAv5EB4+iVmRCnaxTjtq7J1IfeR4y jxKZCR4LVFV3NfQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5ggV3HDsFt0LWN1I1abvUcZhYwt4qpBk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAyNCBTYWx0ZWRfX4F/oMo9OC/qt
 AhIej/5UKDf2hJdSNjIUi8Gr8mj9r45WU90LPxEz7oh3+pW7RUAyp8A7c+JDQ/jAYjVRJhfeySk
 5BtXeG/sShMWON1CWCC5Ewr9afc06oQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAyNCBTYWx0ZWRfX/RMy+UXaj0fp
 LGGo3BGADmqYNG8hDWWrciNxE2+37FiiBKm4gL9K/fubqneCAig5ZQxdQEjQa1jknl7ygS+cvwM
 H9t+6FVmBncgKUXmvWuNnl2sib1HUrw9jNZ+/o65O2ihgXoMTElUn1LeGRTRKZUrTwsFsOArCPe
 9NVYModayphfvCCxK4Qk6Ndz8HW/HLs94ZYiVxhChD4LjB6ZeNcTuwBZKWtNlCBWAVt5PvDZ/Gg
 kVRMbm5sG0wPkM4qL3k2wmpRMRUwgGpV1bwMzGqgnKo7ly2aftl0ELVM8cdD5q4jL4f0GHsmxKt
 PkRrJZ2zbVfDKhbKGw+xEKQEbzahRhfk2dUtFH+IZBCUQJgjL5uHbIW4lGD5wcgmMNEGWQ8j/Xx
 6cQiybB+MsdpRvGu+rcsA2T6DpSR2Vp9GpdhYAiubQSuABCIk4KpJn0bNmxvtuob/RWo7lS2V1W
 nbSIzeMyuw1n966U7Cw==
X-Proofpoint-GUID: 5ggV3HDsFt0LWN1I1abvUcZhYwt4qpBk
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abdf8e5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=aMQYPRUqVwEaD7bFCZwA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010024

Properties varying per variant of the device should still have the
broadest constraints set in the top level, so add such for the "resets".
Since top-level part says "reset-names" cannot accept one item, disallow
it for the two variants which do not use it in practice.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index b9d9dd7a7967..ca92e1a9a051 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -132,7 +132,9 @@ properties:
   power-domains:
     maxItems: 1
 
-  resets: true
+  resets:
+    minItems: 1
+    maxItems: 2
 
   reset-names:
     items:
@@ -209,7 +211,6 @@ allOf:
 
         resets:
           minItems: 2
-          maxItems: 2
 
   - if:
       properties:
@@ -231,6 +232,8 @@ allOf:
         resets:
           maxItems: 1
 
+        reset-names: false
+
   - if:
       properties:
         compatible:
@@ -246,7 +249,6 @@ allOf:
 
         resets:
           minItems: 2
-          maxItems: 2
 
   - if:
       properties:
-- 
2.53.0

