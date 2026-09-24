//
//  CalendarSheetFooter.swift
//  Habits
//
//  Created by Andrey on 22/07/2026.
//

import SwiftUI

struct CalendarSheetFooter: View {
    let metrics: [FooterMetric]

    private var metricsEnumerated: [(offset: Int, element: FooterMetric)] {
        Array(metrics.enumerated())
    }

    init(_ metrics: [FooterMetric]) {
        self.metrics = metrics
    }

    var body: some View {
        HStack {
            ForEach(metricsEnumerated, id: \.element.id) { index, metric in
                metricView(metric)
                if index != metricsEnumerated.indices.last { Spacer() }
            }
        }
    }

    @ViewBuilder private func metricView(_ metric: FooterMetric) -> some View {
        VStack(spacing: 2.0) {
            if let header = metric.header {
                Text(header)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.labelPrimary)
            }
            HStack(alignment: .firstTextBaseline, spacing: metric.metricToImageSpacing) {
                if let value = metric.value {
                    Text(value)
                }
                if let imageSystemName = metric.imageSystemName {
                    Image(systemName: imageSystemName)
                }
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.sheetCalendarFooterStatsPrimary)
        }
    }
}

#Preview {
    let percentage = (Double(147) / Double(255) * 100).formatted(.number.precision(.fractionLength(0...2)))

    CalendarSheetFooter([
        FooterMetric(
            header: "Counter",
            value: "147 Carrots",
            imageSystemName: "carrot",
        ),
        FooterMetric(
            header: "Percentage",
            value: "\(percentage)",
            imageSystemName: "percent",
            metricToImageSpacing: 1.0
        ),
        FooterMetric(
            header: "Category",
            value: "Flowers",
            imageSystemName: "camera.macro.circle",
        ),
        FooterMetric(
            header: "Plain Metric",
            value: ("609")
        ),
    ])
    .padding(.horizontal)
}
